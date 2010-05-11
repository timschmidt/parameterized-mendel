/*
 *  Remake of the main extruder block for Wade's geared extruder
 *  by Len Trigg <lenbok@gmail.com> 2010-05-08
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

// Standard Wade extruder dimensions
mount_thickness = 5;
motor_mount_height = 51.5;
motor_mount_width = 57;
extruder_mount_length = 110;
extruder_mount_width = 28;
extruder_mount_hole_separation = 50;
extruder_block_width = 33;
extruder_block_width_final = 24;
filament_rad=2.1;
ptfe_rad=8.5;
ptfe_depth=10;
m8_height_off=31.5;
m8_rad=4.6;
bearing_rad=11.2;
bearing_width=7;
hex_nut_rad=4;
hex_nut_depth=4;
slot_height = 3;
slot_width = 16;
slot_offset_x = 23.5;
slot_offset_y = 14;

// Modifications to shrink it carefully to make it fit on a makerbot build platform
// Comment these out if you want the regular one
motor_mount_width = 52;
extruder_mount_length = 98;
slot_offset_x = 22;
slot_width = 14.5;


module motor_mount_holes() {
    motor_center_x = motor_mount_width/2;
    motor_center_y = motor_mount_height/2+5.8;
    motor_mount_hole_rad = 11.5;
    // Top two slots
    translate([motor_center_x-slot_offset_x, motor_center_y+slot_offset_y, -1])
    cube([slot_width, slot_height, mount_thickness+2]);
    translate([motor_center_x+slot_offset_x-slot_width, motor_center_y+slot_offset_y, -1])
    cube([slot_width, slot_height, mount_thickness+2]);
    // Bottom two slots
    translate([motor_center_x-slot_offset_x, motor_center_y-slot_offset_y-slot_height, -1])
    cube([slot_width, slot_height, mount_thickness+2]);
    translate([motor_center_x+slot_offset_x-slot_width, motor_center_y-slot_offset_y-slot_height, -1])
    cube([slot_width, slot_height, mount_thickness+2]);
    // Center removed piece
    translate([motor_center_x-6.5, motor_center_y, -1]) cylinder(h=mount_thickness+2, r=motor_mount_hole_rad);
    translate([motor_center_x+6.5, motor_center_y, -1]) cylinder(h=mount_thickness+2, r=motor_mount_hole_rad);
    translate([motor_center_x-6.5, motor_center_y-motor_mount_hole_rad, -1]) cube([6.5*2,motor_mount_hole_rad*2, mount_thickness+2]);
}

module motor_mount_plate() {
    difference() {
        cube([motor_mount_width, motor_mount_height, mount_thickness]);
        motor_mount_holes();
    }
}

module extruder_mount_plate() {
    difference() {
        cube([extruder_mount_length, mount_thickness, extruder_mount_width]);
        union() {
            // Chop the ends a little
            translate([0,-1,8]) rotate([0,-45,0]) cube(extruder_mount_width*2, mount_thickness+2, extruder_mount_width*2);
            translate([extruder_mount_length,-1,extruder_mount_width-10]) rotate([0,-45,0]) cube(extruder_mount_width*2, mount_thickness+2, extruder_mount_width*2);
            translate([extruder_mount_length,-1,10]) rotate([0,135,0]) cube(extruder_mount_width*2, mount_thickness+2, extruder_mount_width*2);

            // Mounting holes
            translate([motor_mount_width - 10, -1, extruder_mount_width/2])
            union() {
                rotate([0,90,90]) cylinder(h=mount_thickness+2, r=2.5, $fn=15);
                translate([extruder_mount_hole_separation, 0, 0]) rotate([0,90,90]) cylinder(h=mount_thickness+2, r=2.5, $fn=15);
            }
        }
    }
}

module hex_head_hole() {
    translate([-1,0,0]) rotate([-90,0,-90]) {
        cylinder(r=hex_nut_rad,h=hex_nut_depth+1,$fn=6);
        cylinder(r=2.0,h=extruder_mount_width+2,$fn=30);
    }
}

module extruder_holes() {
    // Filament and ptfe insulator
    translate([m8_rad,-1,0.6]) {
        rotate([-90,0,0]) {
            cylinder(r=filament_rad,h=motor_mount_height+2,$fn=30);
            cylinder(r=ptfe_rad,h=ptfe_depth+1,$fn=30);
        }
    }
    // Screw holes into ptfe insulator
    ptfe_screw_offset=ptfe_rad-2.4;
    translate([m8_rad-ptfe_screw_offset,5,-extruder_mount_width/2-1]) cylinder(r=1.5,h=extruder_mount_width+2,$fn=15);
    translate([m8_rad+ptfe_screw_offset,5,-extruder_mount_width/2-1]) cylinder(r=1.5,h=extruder_mount_width+2,$fn=15);

    
    outer_bearing_off=extruder_mount_width/2-bearing_width/2;
    // M8 shaft, leave a thin disk to be removed after printing
    translate([0,m8_height_off,-outer_bearing_off+4]) cylinder(r=m8_rad,h=11.5,$fn=40,center=false);
    translate([0,m8_height_off,bearing_width/2+2]) cylinder(r=m8_rad,h=10,$fn=40,center=false);

    // bearings for M8 shaft
    translate([0,m8_height_off,outer_bearing_off]) cylinder(r=bearing_rad,h=bearing_width+0.01,$fn=40,center=true);
    translate([0,m8_height_off,-outer_bearing_off]) cylinder(r=bearing_rad,h=bearing_width+0.01,$fn=40,center=true);
    
    // Idler bearing slot
    z_offset=1;
    translate([13,m8_height_off,z_offset]) cylinder(r=bearing_rad,h=bearing_width+1,$fn=40,center=true);

    // Idler block attachment screws
    screw_off_y=13.1;
    screw_off_z=6.6;
    translate([-13,m8_height_off-screw_off_y,z_offset+screw_off_z]) hex_head_hole();
    translate([-13,m8_height_off+screw_off_y,z_offset+screw_off_z]) hex_head_hole();
    translate([-13,m8_height_off-screw_off_y,z_offset-screw_off_z]) hex_head_hole();
    translate([-13,m8_height_off+screw_off_y,z_offset-screw_off_z]) hex_head_hole();
}

module m8_extruder_block() {
    difference() {
        union() {
            translate([-motor_mount_width,0,0]) motor_mount_plate();
            translate([-motor_mount_width,0,0]) extruder_mount_plate();
            cube([extruder_block_width, motor_mount_height, extruder_mount_width]);
        }
        union() {
            translate([extruder_block_width_final,11, -1]) cube([extruder_block_width, motor_mount_height, extruder_mount_width+2]);
            translate([13.5,0,extruder_mount_width/2]) extruder_holes();
        }
    }
}

// In case you want to see the original for comparison purposes
module m8_extruder_block_orig() {
    import_stl("M8_Extruder_Block_3.stl");
}
// translate([-motor_mount_width,0,-28]) m8_extruder_block_orig();

// Position to build nicely on the (or at least my) makerbot platform
translate([motor_mount_width/2,motor_mount_height-46,0]) rotate([0,0,90]) m8_extruder_block();