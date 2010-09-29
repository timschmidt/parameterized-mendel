// Parametric Mendel DC Motor Extruder in SCAD by Vik,
// vik@diamondage.co.nz, 2010-04-19

<mendel_misc.inc>

bearing_clearance_rad=8;
filament_rad=1.6;		// Includes some clearance.
ptfe_rad=9.2;			// 18mm dia PTFE spacer (9.2). May well be 16mm rad for you (8.2)
extruder_clamp_thick=30;
filament_x_offset=26.497;
dc_motor_rad=11.6;
pinchwheel_rad=3.5;
extruder_axle_line=extruder_height*0.45;
extruder_width=62;

filament_oversize=0.5;	// If your extruder is perfect this can be zero :)
module filament_cavity() {
	union () {
		cylinder(100,filament_rad+filament_oversize,filament_rad+filament_oversize,center=true);
		translate ([0.7*filament_rad,0,0]) rotate ([0,0,45]) {
			cube([filament_rad+filament_oversize,filament_rad+filament_oversize,100],center=true);
		}
	}
}

module extruder_dc_body() {
	difference () {
		union () {
			// Main block of the thing.
	       		translate([extruder_width/2-2,extruder_thick/2,22])cube([extruder_width,extruder_thick,extruder_height], center = true);
			// PTFE holder (for woodscrews instead of epoxy)
			translate([filament_x_offset,extruder_thick/2,0])cube([22,extruder_thick,20], center = true);
			// Motor holder
			translate ([filament_x_offset-1,extruder_thick+16,extruder_axle_line]) {
				translate ([-dc_motor_rad-3,0,0]) box(12,32,12);
				difference () {
					box(dc_motor_rad*2+8,32,dc_motor_rad*2+7);
					translate ([13,-1,0]) rotate ([0,0,45]) translate ([0,-dc_motor_rad*2,0]) box(dc_motor_rad*3,38,dc_motor_rad*3);
				}
			}
		}
	union()
		{
		// Holes for screwing terminal strip to
		translate([extruder_width/2-2,0,extruder_height-5]) rotate([90,0,0]) {
			translate([-8,0,0]) cylinder(h=30,r=1.7,center=true);
			translate([8,0,0]) cylinder(h=30,r=1.7,center=true);
		}
		// Shoulders.
		translate([58.5,extruder_thick/2,40])cube([17,extruder_thick*2.1,21],center=true);
		translate([ 2.8 ,extruder_thick/2, 40])cube([13.399,extruder_thick*2.1,21],center = true);
		// Cutout for 10mm mounting screw washer
		translate ([4+extruder_mount_hole_spacing,extruder_thick/2,39.5]) cylinder(h=20,r=5,center=true);

		translate ([filament_x_offset,0,extruder_axle_line]) {
			// M8 threaded shaft with bearing on the end - oversize
			translate ([bearing_608_rad_v+filament_rad-1,0,0]) {
				rotate ([90,0,0]) scale(1.22) m8_hole_vert(extruder_thick*2);
				translate ([0,extruder_thick*0.25,0]) rotate ([-90,0,0]) cylinder(h=100,r=bearing_608_rad_v+1);
			}
			// Motor cavity
			translate ([1-filament_rad-pinchwheel_rad,0,0]) {
				##translate([0,extruder_thick*0.72,0]) rotate ([-90,0,0]) cylinder(h=44,r=dc_motor_rad);
				// Oversize hole for gear to enter through
				rotate ([90,0,0]) scale(1.1) m8_hole_vert(extruder_thick*2);
			}
			// Tidy-up of centre
			translate([0,extruder_thick-6,0]) box(9,16,9);
		}

		//Yer filament.
		translate([filament_x_offset,extruder_thick/2,21.635])rotate([0,0,90]) {
			 filament_cavity();
			// Conical hole to make filament feed easier.
			translate ([0,0,-7])
			cylinder(h=6,r1=filament_rad+filament_oversize,r2=(filament_rad+filament_oversize)*1.7,center=true);
		}
		// M4 motor clamp.
		translate([filament_x_offset+9,extruder_thick+22,extruder_axle_line])rotate([0,0,90])
			m4_hole_horiz(extruder_height*1.1);

		// M4 mounting holes
		translate([4,extruder_thick/2,22.0])rotate([0,0,90]) m4_hole_horiz(extruder_height*1.1);
		translate([4+extruder_mount_hole_spacing,extruder_thick/2.09,22])rotate([0,0,90])
			m4_hole_horiz(extruder_height*1.1);
		// Split PTFE holder
		translate([filament_x_offset,extruder_thick/2,-2.5]) rotate ([90,0,0]) rotate([90,0,0])cylinder(h=20,r=ptfe_rad,center=true);
		translate([filament_x_offset ,extruder_thick/2, -2.5])cube([3.4,20.889,18],center = true);
		// 3mm holes for woodscrews
		translate([filament_x_offset-6.5,extruder_thick/2,-1.4]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);
		translate([filament_x_offset+6.5,extruder_thick/2,-1.4]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);
		}
	}
}

//rotate ([90,0,0]) 
	extruder_dc_body();

