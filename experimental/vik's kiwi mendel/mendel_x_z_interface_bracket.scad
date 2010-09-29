// 
/*
 *  OpenSCAD Shapes Library (www.openscad.at)
 *  Z axis/X axis interface clamp for Mendel
 *  by Vik Olliver. Based on examples which are:
 *  Copyright (C) 2009  Catarina Mota <clifford@clifford.at>
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
 * Modified by Vik 21-Mar-2010 
*	Allow Z drive rod more space to pass.
*	Parameterise Z rail to allow 9mm aluminium tube etc.
*/

// Useful constants etc.
generic_clearance=1;
m3_clearance_rad=1.9;
m4_clearance_rad=2.8;
m6_clearance_rad=3.7;
m8_tight_rad=4.65;
m8_clearance_rad=4.9;

x_rail_sep=60.5-8;
lower_bracket_width=84;
lower_bracket_base_width=8;
lower_bracket_base_height=15;
lower_bracket_length=28; // Also max dimension on X axis
// The rail clamps.
rail_clamp_width=20;
rail_clamp_height=15;
rail_rad=m8_tight_rad;	// X rail. 3.6 for 1/4" bar, 5.3 for aluminium rod, or m8_tight_rad for 8mm bar
z_rail_rad=m8_clearance_rad;	// Usually m8_clearance_rad. Adjust for your Z rail radius

nema17_side=44;


module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}

module roundedBox(w,h,d,f){
	difference(){
		box(w,h,d);
		translate([-w/2,h/2,0]) cube(w/(f/2),true);
		translate([w/2,h/2,0]) cube(w/(f/2),true);
		translate([-w/2,-h/2,0]) cube(w/(f/2),true);
		translate([w/2,-h/2,0]) cube(w/(f/2),true);
	}
	translate([-w/2+w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([-w/2+w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
}
module hexagon(height, depth) {
	boxWidth=height/1.75;
		union(){
			box(boxWidth, height, depth);
			rotate([0,0,60]) box(boxWidth, height, depth);
			rotate([0,0,-60]) box(boxWidth, height, depth);
		}
}

module m4_hole_horiz(l) {
	cylinder(l,m4_clearance_rad,m4_clearance_rad,center=true);
	translate ([m4_clearance_rad*0.6,0,0]) rotate ([0,0,45])
		cube([m4_clearance_rad,m4_clearance_rad,l],center=true);
}

module m8_hole_horiz(l) {
	cylinder(l,m8_clearance_rad,m4_clearance_rad,center=true);
	translate ([m8_clearance_rad*0.6,0,0]) rotate ([0,0,45])
		cube([m8_clearance_rad,m8_clearance_rad,l],center=true);
}

module m4_hole_vert(l) {
	cylinder(l,m4_clearance_rad,m4_clearance_rad,center=true);
}

module m6_hole_horiz(l) {
	cylinder(l,m6_clearance_rad,m6_clearance_rad,center=true);
	translate ([m6_clearance_rad*0.6,0,0]) rotate ([0,0,45])
		cube([m6_clearance_rad,m6_clearance_rad,l],center=true);
}
module m8_hole_horiz(l) {
	cylinder(l,m8_clearance_rad,m8_clearance_rad,center=true);
	translate ([m8_clearance_rad*0.6,0,0]) rotate ([0,0,45])
		cube([m8_clearance_rad,m8_clearance_rad,l],center=true);
}

// No .4 3/4 inch countersunk woodscrew (includes a lot of headspace)
module small_woodscrew() {
	rotate ([0,0,30]) {
		translate ([0,0,-7.5]) cylinder(h=3,r1=0.2,r2=1.8,center=true);
		cylinder(h=12,r1=1.8,r2=2.0,center=true);
		translate([0,0,6]) cylinder(h=4, r1=2.0, r2=4.0);
	}
}

// For nut cavities, "height" is the max distance between two points on the hex.
module m4_nut_cavity(l) {
	hexagon(height=8,depth=l);
}

module m8_nut_cavity(l) {
	hexagon(height=14,depth=l);
}

module m4_hole_vert_with_hex(l) {
	union () {
		m4_hole_vert(l);
		translate ([0,0,-l/4]) rotate ([0,0,30]) m4_nut_cavity(l/2);
	}
}

module m4_hole_horiz_with_hex(l) {
	union () {
		m4_hole_horiz(l);
		translate ([0,0,-l/4]) rotate ([0,0,0]) m4_nut_cavity(l/2);
	}
}

module rail_clamp () {
	translate ([lower_bracket_length/2,0,0]) {
		difference () {
			// Rail clamp body
			box(lower_bracket_length,rail_clamp_height*2,rail_clamp_width);
			// Diagonal ramp at start
			rotate ([0,45,0]) translate ([1-lower_bracket_length/2,0,-1.9*rail_clamp_height])
				box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);		
			// Diagonal side
			 translate ([-lower_bracket_length/2,-rail_clamp_width,0]) rotate ([0,0,-45])
				translate ([0,-rail_clamp_width/2,-rail_clamp_height]) 
					box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);
			 rotate ([180,0,0]) translate ([-lower_bracket_length/2,-rail_clamp_width,0]) rotate ([0,0,-45])
				translate ([0,-rail_clamp_width/2,rail_clamp_height]) 
					box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);
		}
	}
}

module horizontal_body() {
	union () {
		translate ([0,0,2])
			difference () {
				box(lower_bracket_base_height,lower_bracket_width,lower_bracket_base_width*2);
				translate ([0,0,2-lower_bracket_base_width])					
					box(rail_clamp_width*2,lower_bracket_length-20,lower_bracket_base_width*2);
			}
		translate ([6,-x_rail_sep/2,0]) rail_clamp();
		translate ([6,x_rail_sep/2,0]) rail_clamp();
	}
}

vbody_length=15;
vbody_width=20;
vbody_height=75;
vbody_slot_width=6;
vbody_slot_depth=15;
vbody_z_drive_cutout=10;

// Holds two sprung sliders for the Z axis.
module vertical_body () {
	difference () {
		box (vbody_length,vbody_width,vbody_height);
		// Slots for Z rail guides
		translate ([0,0,(vbody_height-vbody_slot_depth)/2])  {
			box(vbody_length*2,vbody_slot_width,vbody_slot_depth+0.1);
			translate ([vbody_length/2,0,0]) rotate ([0,0,45]) box(vbody_z_drive_cutout,vbody_z_drive_cutout,vbody_slot_depth+0.1);
			translate ([0,vbody_slot_width+1,0]) rotate ([90,0,0]) m4_hole_horiz_with_hex(vbody_width*2);
		}
		translate ([0,0,(vbody_height-vbody_slot_depth)/-2]) {
			box(vbody_length*2,vbody_slot_width,vbody_slot_depth+0.1);
			translate ([vbody_length/2,0,0]) rotate ([0,0,45]) box(vbody_z_drive_cutout,vbody_z_drive_cutout,vbody_slot_depth+0.1);
			translate ([0,vbody_slot_width+1,0]) rotate ([90,0,0]) m4_hole_horiz_with_hex(vbody_width*2);
		}
	}
}

nut_trap_len=20;
nut_trap_height=32;
nut_trap_width=x_rail_sep-rail_clamp_width;
nut_spring_clearance=2.5;

// Holds 2x M8 nuts with an anti-backlash spring between them.
module z_nut_trap () {
	translate ([nut_trap_len/2-2,0,0]) {
		difference () {
			// Main body.
			box(nut_trap_len,nut_trap_width,nut_trap_height);
			// Nut holders
			translate ([0,0,nut_trap_height/2-4]) m8_nut_cavity(10);
			translate ([0,0,-(nut_trap_height/2-4)]) m8_nut_cavity(10);
			// Nice, big hole for threaded Z axis drive rod
			cylinder(h=nut_trap_height, r=m8_clearance_rad+0.4, center=true);
			// Spring
			box(nut_trap_len*1.1,nut_trap_width-2*nut_spring_clearance,nut_spring_clearance);
			translate ([0,0,(nut_trap_height/2)-5-nut_spring_clearance])
				box(nut_trap_len*1.1,nut_trap_width-2*nut_spring_clearance,nut_spring_clearance);
			translate ([0,0,-((nut_trap_height/2)-5-nut_spring_clearance)])
				box(nut_trap_len*1.1,nut_trap_width-2*nut_spring_clearance,nut_spring_clearance);
			translate ([0,0,((nut_trap_height/2)-5-nut_spring_clearance)/2])
				box(nut_trap_len*1.1,nut_trap_width-2*nut_spring_clearance,nut_spring_clearance);
			translate ([0,0,((nut_trap_height/2)-5-nut_spring_clearance)/-2])
				box(nut_trap_len*1.1,nut_trap_width-2*nut_spring_clearance,nut_spring_clearance);
			// Slot parallel to thread axis
			translate ([0,0,((nut_trap_height/2)-12-nut_spring_clearance)/-2])
				box(nut_trap_width-2*nut_spring_clearance,nut_spring_clearance,nut_trap_len*1.1);
			// Diagonal slots.
			rotate ([0,0,45]) translate ([-nut_trap_len/2,0,0])
				box(nut_trap_width-2*nut_spring_clearance,nut_spring_clearance,nut_trap_len*1.1);
			rotate ([0,0,-45]) translate ([-nut_trap_len/2,0,0])
				box(nut_trap_width-2*nut_spring_clearance,nut_spring_clearance,nut_trap_len*1.1);
		}
		// Prop.
		translate ([(lower_bracket_base_height+nut_trap_len)/-2+2,0,0])
			box(lower_bracket_base_height,nut_trap_width-2,nut_trap_height);
	}
}

belt_slot_width=3;
belt_slot_height=3;

module x_z_interface_bracket () {
	difference () {
		union () {
			horizontal_body();
			vertical_body();
			translate([nut_trap_height-5,-1,0]) box(10,5,nut_trap_height);
			translate ([vbody_length/2,0,0]) z_nut_trap();
		}
		// Outer bearings
		translate ([0,(lower_bracket_width-12)/2,4-lower_bracket_base_width]) m4_hole_horiz_with_hex(50);
		translate ([0,(lower_bracket_width-12)/-2,4-lower_bracket_base_width]) m4_hole_horiz_with_hex(50);
		// Rails
		translate ([0,x_rail_sep/2,0]) rotate ([0,90,0]) cylinder(h=200,r=rail_rad,center=true);
		translate ([108,(x_rail_sep/2)+12,0]) box(200,40,2);
		translate ([0,-x_rail_sep/2,0]) rotate ([0,90,0]) cylinder(h=200,r=rail_rad,center=true);
		rotate ([180,0,0]) translate ([108,(x_rail_sep/2)+12,0]) box(200,40,2);
		// Holes for rail grips.
		translate ([lower_bracket_length*0.7,x_rail_sep/2+m8_tight_rad*2-1,-7]) m4_hole_horiz_with_hex(60);
		translate ([lower_bracket_length*0.7,-(x_rail_sep/2+m8_tight_rad*2)+1,-7]) m4_hole_horiz_with_hex(60);
		// Slots for belt passage
		translate ([-lower_bracket_length*2,(x_rail_sep+rail_clamp_width)/2+belt_slot_width+3,-rail_clamp_height/2-2])	// Dunno why 2.
			scale (2) box(lower_bracket_length*4,belt_slot_width,belt_slot_height);
		translate ([-lower_bracket_length*2,(x_rail_sep+rail_clamp_width)/-2-belt_slot_width-3,-rail_clamp_height/2-2])	// Dunno why 2.
			scale (2) box(lower_bracket_length*4,belt_slot_width,belt_slot_height);
		// Slot "round the back"
		translate ([-rail_clamp_height/2,0,-rail_clamp_width/2-2]) rotate ([0,45,0]) rotate ([0,0,90]) box(lower_bracket_length*5,6,6);
	}
}


z_spring_length=6; // That has to fit between the interface bracket and the Z rail
z_spring_width=48;
z_spring_thickness=2.2;
z_spring_end=vbody_width/2-z_spring_thickness+z_spring_length-3;

// Simple V-spring.
vspring_cubic=vbody_width*0.85;
module v_spring () {
	difference () {
		rotate ([0,0,45]) box(vspring_cubic,vspring_cubic,vbody_slot_depth);
		rotate ([0,0,45]) translate ([z_spring_thickness,z_spring_thickness,0]) box(vspring_cubic,vspring_cubic,vbody_slot_depth*2);
		rotate ([90,-90,0]) scale(0.9) m8_hole_horiz(z_spring_width);
	}
}

// A sprung saddle originally designed to fit an 8mm rod
module z_saddle() {
	translate ([0,0,vbody_slot_depth/2]) {
		union () {
			difference () {
				union () {
					translate([-1,0,0]) box(vbody_width-1,vbody_slot_width-generic_clearance,vbody_slot_depth);
					translate([-vbody_width/2-0.2,0,0]) rotate ([0,0,45])
						box(vbody_z_drive_cutout,vbody_z_drive_cutout,vbody_slot_depth);
					translate([(vbody_width+z_spring_length)/2+z_spring_thickness,0,0])
						box(z_spring_length,z_spring_width,vbody_slot_depth);
					translate([(vbody_width+z_spring_length)/-2+z_spring_thickness,0,0])
						box(z_spring_thickness,z_spring_width,vbody_slot_depth);	
				}
				// Allow some wiggle-room on the retaining bolt
				scale (1.2) rotate ([90,-90,0]) m4_hole_horiz(vbody_slot_width*2);
				// Bit that grabs the rail
				translate ([vbody_width/2+z_spring_length+z_rail_rad-2.5,0,0])
					cylinder(h=vbody_slot_depth*2,r=z_rail_rad,center=true);
				// Gap to let Z drive rod pass
				translate([-vbody_width/2-z_spring_thickness*2,0,0]) rotate ([0,0,45])
					box(vbody_z_drive_cutout,vbody_z_drive_cutout,vbody_slot_depth+0.1);
			}
			translate ([z_spring_thickness/2,z_spring_width*0.47,0]) v_spring();
			translate ([z_spring_thickness/2,-z_spring_width*0.47,0]) rotate ([0,0,180]) v_spring();
		}
	}
}

translate ([30,50,0]) rotate ([0,-90,0]) translate([lower_bracket_base_height/2,0,0])
	x_z_interface_bracket();

translate ([53,5,0]) z_saddle();
translate ([53,95,0]) z_saddle();
