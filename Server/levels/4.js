import GameLevel from "#concepts/level";

export default new GameLevel({
    name: 'Four',
    room_name: 'rFour',
    start_pos: [{x:288,y:384}, {x:672,y:128}, {x:768,y:640}, {x:1216,y:416}],
    spawn_type: 'distributed'
});
