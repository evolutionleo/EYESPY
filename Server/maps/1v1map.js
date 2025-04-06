import { levelFind } from "#concepts/level";
import GameMap from "#concepts/map";

let level = levelFind('First');
let levels = [level, level, level];

// shuffle randomly
levels.sort((a, b) => Math.random() > 0.5 ? 1 : -1);

export default new GameMap(levels, '1v1');
