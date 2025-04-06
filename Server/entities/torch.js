import Entity from "#concepts/entity";

export default class Torch extends Entity {
    static object_name = 'oTorch';
    static type = 'Torch';
    is_solid = false;

    base_size = {
        x: 16,
        y: 16
    };

    scale = {
        x: 1,
        y: 1
    }

    color = 'none';

    prop_names = ['color'];

    update(dt) {
        super.update(dt);
    }
}