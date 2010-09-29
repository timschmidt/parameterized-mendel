// Parametric Mendel Extruder in SCAD by Vik, based on SCAD conversion by rbisping
// vik@diamondage.co.nz, 2010-01-02
// Pinch bearing & filament size is parametric. Also added pointy tops to horizontal holes.
// 2010-04-05
// Now using mendel_misc.inc, moved anchor holes to fit carriage better,
// made extruder body thicker and added a space for one mounting screw
// washer to go in.

<mendel_misc.inc>

bearing_clearance_rad=8;
filament_rad=1.6;		// Includes some clearance.
ptfe_rad=9.2;			// 18mm dia PTFE spacer (9.2). May well be 16mm rad for you (8.2)
extruder_clamp_thick=30;
filament_x_offset=26.497;

filament_oversize=0.5;	// If your extruder is perfect this can be zero :)
module filament_cavity() {
	union () {
		cylinder(100,filament_rad+filament_oversize,filament_rad+filament_oversize,center=true);
		translate ([0.6*filament_rad,0,0]) rotate ([0,0,45])
			cube([filament_rad+filament_oversize,filament_rad+filament_oversize,100],center=true);
	}
}

module pinchwheel()
{
translate([-40,10,0])rotate(90,[1,0,0])
{
difference()
	{
	union()
		{
		// Main block of the thing.
       		translate([29,extruder_thick/2,22])cube([61,extruder_thick,extruder_height], center = true);
		// Side piece for motor anti-slippage screw.
		translate ([52,0,(extruder_height-15)/2-8]) cube([12,extruder_clamp_thick,25]);
		// PTFE holder (for woodscrews instead of epoxy)
		translate([filament_x_offset,extruder_thick/2,0])cube([22,extruder_thick,20], center = true);
		}
	union()
		{
		// Shoulders.
		translate([58.5,extruder_thick/2,40])cube([17,extruder_thick*2.1,21],center=true);
		translate([ 3.75 ,extruder_thick/2, 40])cube([11.399,extruder_thick*2.1,21],center = true);
		// Cutout for 10mm mounting screw washer
		translate ([4+extruder_mount_hole_spacing,extruder_thick/2,39.5]) cylinder(h=20,r=5,center=true);
		// Slots for NEMA 17 M3 mounting screws
		translate([14.374,extruder_thick,5.5]) m3_slot(extruder_thick*2.1);
		translate([45.374,extruder_thick,5.5]) m3_slot(extruder_thick*2.1);
		translate([14.374,extruder_thick,36.5]) m3_slot(extruder_thick*2.1);
		translate([45.374,extruder_thick,36.5]) m3_slot(extruder_thick*2.1);

		translate([30.5,9,21])rotate(90,[1,0,0])cylinder(24,6,6,center=true);
		translate([30.492,17.756,20.988])cube([27.975,7.486,23.035],center=true);

		// Cutout for bearing
		translate([29-bearing_clearance_rad-filament_rad,extruder_thick-3,21]) {
			// Circular recess for bearing
			rotate(90,[1,0,0])
				cylinder(21.63,bearing_clearance_rad,bearing_clearance_rad,center=true);
			// Bolt hole for bearing (bit of slack)
			rotate(90,[1,0,0]) cylinder(80,m4_clearance_rad_v+0.2,m4_clearance_rad_v+0.2,center=true);
			// Slants tangental to bearing edge.
			rotate(10,[0,1,0]) translate([0,-21.63/2,0])
				cube([13.258,21.63,bearing_clearance_rad],center=false);
			rotate(-10,[0,1,0]) translate([0,-21.63/2,-bearing_clearance_rad])
				cube([13.258,21.63,bearing_clearance_rad],center=false);
		}

		//Yer filament.
		translate([filament_x_offset,extruder_thick/2,21.635])rotate([0,0,90]) {
			 filament_cavity();
			// Conical hole to make filament feed easier.
			translate ([0,0,-7])
				cylinder(h=6,r1=filament_rad+filament_oversize,r2=(filament_rad+filament_oversize)*1.5,center=true);
		}

		// Horizontal M4 holes
		translate([4,extruder_thick/2,22.0])rotate([0,0,90]) m4_hole_horiz(extruder_height*1.1);
		translate([4+extruder_mount_hole_spacing,extruder_thick/2.09,22])rotate([0,0,90]) m4_hole_horiz(extruder_height*1.1);
		// Hex cavity for sideways compression screw.
		translate([55,extruder_clamp_thick-6,extruder_height/2]) rotate([90,0,180]) rotate([0,-90,0])  m4_hole_horiz_with_hex(20);
		// Brace for compression screw block (we *want* washers on it)
		translate([58,extruder_clamp_thick,extruder_height/2-6]) rotate ([90,0,0]) m4_hole_vert(extruder_thick*4);
		// Split PTFE holder
		#translate([filament_x_offset,extruder_thick/2,-2.5]) rotate ([90,0,0]) rotate([90,0,0])cylinder(h=20,r=ptfe_rad,center=true);
		#translate([filament_x_offset ,extruder_thick/2, -2.5])cube([3.4,20.889,18],center = true);
		// 3mm holes for woodscrews
		#translate([filament_x_offset-6.5,extruder_thick/2,-1.4]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);
		#translate([filament_x_offset+6.5,extruder_thick/2,-1.4]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);
		}
	}
}
}

// Put it in X+ve, Y+ve
translate ([40,45,0]) pinchwheel();


		
