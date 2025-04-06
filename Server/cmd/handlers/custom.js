import { addHandler } from "#cmd/handlePacket";

addHandler('player controls', (c, data) => {
    if (!c.entity)
        return;
    
    for (let input_name in c.entity.inputs) {
        if (data[input_name] !== undefined)
            c.entity.inputs[input_name] = data[input_name];
    }
});

addHandler('player pos', (c, data) => {
    if (!c.entity) return;
    if (!c.lobby) return;
    if (data.round != c.lobby.round) return;

    c.entity.x = data.x;
    c.entity.y = data.y;
});

addHandler('next round ready', (c) => {
    if (!c.entity || !c.lobby || !c.room)
        return;

    c.is_next_ready = true;

    if (c.lobby.allPlayersReady()) {
        c.lobby.nextRound();
    }
});

addHandler('online count', (c) => {
    c.send({ cmd: 'online count', n: global.clients.length });
});