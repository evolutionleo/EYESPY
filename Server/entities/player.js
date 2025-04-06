import PhysicsEntity from '#entities/physics_entity';
import Torch from '#entities/torch';
import { lengthdir } from '#util/maths';
import Tear from '#entities/tear';
import trace from '#util/logging';

export function getDefaultInputs() {
    return {
        move: {
            x: 0,
            y: 0
        },
        kright: 0,
        kleft: 0,
        kup: 0,
        kdown: 0,

        kshoot: 0,

        dir: 0
    };
}


export default class PlayerEntity extends PhysicsEntity {
    static type = 'Player';
    static object_name = 'oPlayer';
    
    // collider_type = 'box';
    collider_type = 'circle';
    collider_radius = 32;
    collider_origin = { x: 0, y: 0 };
    
    collision_type = 'discrete';
    precise_collisions = true;
    outside_room_action = 'wrap';
    
    stuck_action = 'stop';
    color = 'none'; // none|blue|red
    
    sendEveryTick = true;
    
    base_size = {
        x: 64,
        y: 64
    };
    
    scale = {
        x: 1,
        y: 1
    };
    
    origin = {
        x: 0,
        y: 0
    };
    
    states = { idle: 0, walk: 1 };
    
    client;
    
    get name() { return this.client.name; }
    prop_names = ['name', 'dir', 'color', 'hp', 'max_hp', 'iframes', 'dead'];
    
    inputs = getDefaultInputs();
    
    
    is_solid = false;
    
    // walksp = 420;
    walksp = 20;
    shootsp = 50;
    dir = 0;
    
    max_hp = 4;
    hp = 4;

    iframes = 0;
    max_iframes = 4;

    shoot_cd = 0;
    max_shoot_cd = 12;

    dead = false;

    constructor(room, x = 0, y = 0, client) {
        super(room, x, y);
        this.client = client;
        // this.color = this.client.color;
    }
    
    create() {
        super.create();
        this.color = this.client.color;
    }
    
    update(dt) {
        if (!this.dead) {
            
            // this.spd.x = this.inputs.move.x * this.walksp;
            // this.spd.y = this.inputs.move.y * this.walksp;

            this.dir = this.inputs.dir;


            let torches = this.placeMeetingAll(this.x, this.y, Torch);
            for(let torch of torches) {
                torch.color = this.color;
            }

            this.shoot_cd -= dt;
            if (this.inputs.kshoot && (this.shoot_cd <= 0)) {
                this.shoot_cd = this.max_shoot_cd;

                let tear = this.room.spawnEntity(Tear, this.x, this.y);
                tear.angle = this.dir;
                tear.color = this.color;
                tear.spd = lengthdir(this.shootsp, this.dir);
            }
            
            this.iframes -= dt;
            this.handleHealth();

        }
        
        super.update(dt);
        let p = this.client.profile;
        if (p) {
            p.state.state = this.state;
            p.state.x = this.x;
            p.state.y = this.y;
        }
    }


    handleHealth() {
        this.hp = Math.max(this.hp, 0);
        this.hp = Math.min(this.hp, this.max_hp);

        if (this.hp <= 0 && !this.dead) {
            this.die();
        }
    }

    hurt(amount) {
        if (this.iframes > 0)
            return;

        this.iframes = this.max_iframes;
        this.hp -= amount;
        this.handleHealth();
    }

    die() {
        this.dead = true;
        this.client.lobby.score[this.color == 'red' ? 'blue' : 'red']++;
        // super.die();
        // placeholder
        // console.log('died lol');
    }
}
