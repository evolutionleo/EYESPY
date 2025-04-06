import trace from '#util/logging';
import Room  from '#concepts/room';
import { EventEmitter } from 'events';
import { gameModeFind } from '#concepts/game_mode';
import { getRandomId } from '#util/random_id';


// note: only create lobbies with createLobby(), don't call the constructor directly
export function lobbyCreate(map) {
    let lobby_id = getRandomId();
    if (lobby_id === null)
        return null;
    
    let lobby = new Lobby(map);
    lobby.lobby_id = lobby_id;
    
    global.lobbies[lobby_id] = lobby;
    
    return lobby;
}

export function lobbyFind(lobby_id) {
    return global.lobbies[lobby_id];
}

export function lobbyExists(lobby_id) {
    return global.lobbies.hasOwnProperty(lobby_id);
}

export function lobbyDelete(lobby_id) {
    let lobby = global.lobbies[lobby_id];
    lobby.close();
    
    delete global.lobbies[lobby_id];
}

export function lobbyList() {
    return (Object.values(global.lobbies));
}


// in context of an MMO this is a shard/separated world
export default class Lobby extends EventEmitter {
    lobby_id = '-1'; // assigned when created
    status = 'open';
    /** @type {Client[]} */
    players = [];
    /** @type {Room[]} */
    rooms = null;
    
    map = null;
    game_mode = null;
    match;
    
    // used when creating a lobby with no map/game mode
    max_players = global.config.lobby.max_players || undefined;
    
    
    /** @type {Client[][]} */
    teams = [];
    
    constructor(map = null) {
        super();
        
        this.map = map;
        this.round = 0;
        this.score = {red: 0, blue: 0};

        this.score = {
            red: 0,
            blue: 0
        };
        
        if (this.map !== null) {
            this.game_mode = gameModeFind(this.map.game_mode);
            this.max_players = this.game_mode?.max_players || this.max_players;
            
            if (global.config.rooms_enabled) {
                this.rooms = [];
                
                for (let i = 0; i < this.map.levels.length; i++) {
                    let level = this.map.levels[i];
                    let room = new Room(level, this);
                    this.rooms.push(room);
                }
            }
        }


    }

    nextRound() {
        this.round++;
        if (this.round >= this.rooms.length)
            this.round = 0;

        let room = this.rooms[this.round];
        room.level.shuffleStartPos();

        room.entities.ofType('Torch').forEach(t => t.color = 'none');

        this.broadcast({cmd: 'score', score: this.score});
        
        this.players.forEach(player => {
            player.room.movePlayer(player, room);
            player.is_next_ready = false;
        });
    }

    allPlayersReady() {
        for(let player of this.players) {
            if (!player.is_next_ready)
                return false;
        }
        return true;
    }
    
    /**
     * @param {Client} player
     * @returns {boolean}
     */
    addPlayer(player) {
        if (this.full) {
            trace('warning: can\'t add a player - the lobby is full!');
            player.onLobbyReject(this, 'lobby is full!');
            return false;
        }
        else if (this.players.indexOf(player) !== -1) {
            trace('warning: can\'t add a player who\'s already in the lobby');
            player.onLobbyReject(this, 'already in the lobby');
            return false;
        }
        else if (player.lobby !== null) {
            player.lobby.kickPlayer(player, 'changing lobbies', false);
        }
        else if (global.config.necessary_login && !player.logged_in) {
            trace('warning: can\'t add a player who\'s not logged in');
            player.onLobbyReject(this, 'login to join a lobby!');
            return false;
        }
        
        this.players.push(player);
        player.lobby = this;
        player.color = this.players.length == 1 ? 'red' : 'blue';

        player.onLobbyJoin(this);
        
        
        // lobby is now full - add everyone
        if (global.config.lobby.add_into_play_on_full && this.players.length == this.max_players) {
            this.play();
        }
        else if (global.config.lobby.add_into_play_on_join) {
            // immediately add into play
            this.addIntoPlay(player);
        }
        
        return true;
    }
    
    /**
     * @param {Client} player
     * @param {string?} reason
     * @param {boolean?} forced
     */
    kickPlayer(player, reason, forced = false, secondary = false) {
        if (!this.players.includes(player))
            return;
        
        // close if a player leaves from the lobby?
        if (global.config.lobby.close_on_leave && this.status !== 'closed' && !secondary) {
            if (this.match && !this.match.ended) { // if left mid-match - end the match
                // define winning teams' IDs
                let winning_teams = this.teams.map((t, idx) => t.includes(player) ? -1 : idx).filter(n => n != -1);
                this.match.end(winning_teams, 'player left');
            }
            else
                this.close();
        }
        else {
            if (!secondary && this.match && this.match === player.match) {
                this.match.removePlayer(player, reason, forced, true);
            }
            
            this.teams.forEach(team => {
                let idx = team.indexOf(player);
                if (idx !== -1)
                    team.splice(idx, 1);
            });
            
            let idx = this.players.indexOf(player);
            this.players.splice(idx, 1);
            player.room?.removePlayer(player); // if in a room - kick, otherwise don't error out
            player.onLobbyLeave(this, reason, forced);
            player.lobby = null;
        }
        
    }
    
    /**
     * @param {Client} player
     */
    addIntoPlay(player) {
        if (player.lobby === this) {
            player.onPlay();
        }
        else {
            trace('something went wrong - trying to add a player from another lobby into play');
        }
    }
    
    /**
     * @param {string} room_name
     * @returns {Room} room
     */
    findRoomByLevelName(room_name) {
        return this.rooms.find(r => r.level.name === room_name);
    }
    
    /**
     * @param {object} data
     */
    broadcast(data) {
        this.players.forEach((player) => {
            player.write(data);
        });
    }
    
    // add everyone into play
    play() {
        this.rooms.forEach(room => room.level.shuffleStartPos());

        this.players.forEach((player) => {
            this.addIntoPlay(player);
        });

        this.broadcast({cmd: 'score', score: this.score});
    }
    
    close(reason = 'lobby is closing!') {
        // kick all players
        this.status = 'closed';
        while (this.players.length > 0) {
            this.kickPlayer(this.players[0], reason, true);
        }
        
        // this.players.forEach((player) => this.kickPlayer(player, reason, true));
    }
    
    
    // data that is being sent about this lobby
    // (e.x. we don't want to send functions and everything about every player)
    serialize() {
        return {
            lobby_id: this.lobby_id,
            rooms: global.config.rooms_enabled
                ? this.rooms.map(r => r.serialize())
                : undefined,
            status: this.status,
            max_players: this.max_players,
            player_count: this.player_count,
            full: this.full
        };
    }
    
    getInfo() {
        return {
            lobby_id: this.lobby_id,
            rooms: global.config.rooms_enabled
                ? this.rooms.map(r => r.getInfo())
                : undefined,
            status: this.status,
            max_players: this.max_players,
            player_count: this.player_count,
            full: this.full,
            round: this.round,
            
            map: this.map.getInfo()
        };
    }
    
    get player_count() {
        return this.players.length;
    }
    
    get full() {
        return this.player_count >= this.max_players;
    }
    
    get empty() {
        return this.player_count == 0;
    }
}
