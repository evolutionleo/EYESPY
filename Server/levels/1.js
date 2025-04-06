import GameLevel from "#concepts/level";

export default new GameLevel({
    name: 'First',
    room_name: 'rOne',
    start_pos: [{ x: 160, y: 160 }, { x: 280, y: 640 }, { x:705, y:320}, {x:1217, y:255}, {x:1089, y:640}],
    spawn_type: 'distributed'
});
