import { levelFind } from "#concepts/level";
import GameMap from "#concepts/map";

let levels = [levelFind('First'), levelFind('Second'), levelFind('Third'), levelFind('Four')];

// shuffle randomly
levels.sort((a, b) => Math.random() > 0.5 ? 1 : -1);

export default new GameMap(levels, '1v1');
