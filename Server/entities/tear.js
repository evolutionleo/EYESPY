// import PhysicsEntity from "#entities/physics_entity";
import Entity from "#concepts/entity";

export default class Tear extends Entity {
    static object_name = 'oTear';
    static type = 'Tear';
    is_solid = false;

    
    collider_radius = 12;
    collider_type = 'circle';

    // collider_type = 'box';

    base_size = {
        x: 32,
        y: 32
    };

    scale = {
        x: 1,
        y: 1
    }

    origin = {
        x: 0,
        y: 0
        // x: 0.75,
        // y: 0.5
    }

    color = 'none';
    damage = 1;

    prop_names = ['color'];

    create() {
        super.create();
    }

    update(dt) {
        let dead = false;

        if (this.placeMeeting(this.x + this.spd.x * dt, this.y + this.spd.y * dt)) {
            let spd_magnitute = this.spd.x * this.spd.x + this.spd.y * this.spd.y;
            let dx = this.spd.x / spd_magnitute;
            let dy = this.spd.y / spd_magnitute;

            while(!this.placeMeeting(this.x + dx, this.y + dy)) {
                this.x += dx;
                this.y += dy;
            }

            dead = true;
            this.die();
        }


        let players = this.placeMeetingAll(this.x, this.y, 'Player');
        for(let player of players) {
            if (player.color != this.color) {
                player.hurt(this.damage);
                dead = true;
                this.die();

                this.room.broadcast({ cmd: 'tear hit', uuid: this.uuid, player: player.uuid });
            }
        }


        this.collider.setAngle(this.angle);
        this.updateCollider(this.x, this.y);

        if (!dead) {
            this.x += this.spd.x * dt;
            this.y += this.spd.y * dt;
        }

        super.update(dt);
    }
}