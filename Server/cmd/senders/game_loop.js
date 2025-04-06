import SendStuff from "#cmd/sendStuff";

/**
 * @param {Lobby} lobby
 * @param {Room} room
 * @param {Point} start_pos
 * @param {string} [uuid=undefined]
 */
SendStuff.prototype.sendPlay = function (lobby, room, start_pos, uuid) {
    this.send({ cmd: 'play', lobby: lobby.getInfo(), room: room?.serialize(), start_pos, uuid });
};

/**
 * @param {Room} room_to
 * @param {Point} start_pos
 * @param {string} [uuid=undefined]
 */
SendStuff.prototype.sendRoomTransition = function (room_to, start_pos, uuid) {
    this.send({ cmd: 'room transition', room: room_to.serialize(), start_pos, uuid, round: this.lobby.round });
};

/**
 * @param {'win'|'loss'|'draw'} outcome
 * @param {string?} reason
 */
SendStuff.prototype.sendGameOver = function (outcome, reason = '') {
    this.send({ cmd: 'game over', outcome, reason });
};
