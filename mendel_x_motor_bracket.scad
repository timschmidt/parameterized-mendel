// 
/*
 *  OpenSCAD Shapes Library (www.openscad.at)
 *  One-piece X Motor bracket for Mendel
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
*/

x_rail_sep=60.5-8;
lower_bracket_width=84;
lower_bracket_base_width=9;
lower_bracket_base_height=15;
lower_bracket_length=63; // Also max dimension on X axis
top_notch_height=lower_bracket_length+7.5;
// The rail clamps.
rail_clamp_width=20;
rail_clamp_height=15;

nema17_side=43;

// Useful constants etc.

m3_clearance_rad=1.9;
m4_clearance_rad=2.8;
m6_clearance_rad=3.7;
m8_tight_rad=4.6;
m8_clearance_rad=4.9;

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
module m4_nut_cavity(l) {
	hexagon(height=8,depth=l);
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
			rotate ([0,45,0]) translate ([-lower_bracket_length/2,0,-2.32*rail_clamp_height])
				box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);
			// Diagonal side
			 translate ([-lower_bracket_length/2,-rail_clamp_width,0]) rotate ([0,0,-45])
				translate ([0,-rail_clamp_width/2,-rail_clamp_height]) 
					box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);
			 rotate ([180,0,0]) translate ([-lower_bracket_length/2,-rail_clamp_width,0]) rotate ([0,0,-45])
				translate ([0,-rail_clamp_width/2,rail_clamp_height]) 
					box(lower_bracket_length,rail_clamp_width*2,rail_clamp_height*2);
			// Crimp in the middle
			translate ([6,0,-rail_clamp_height*0.84]) rotate ([0,45,0]) 		
				box(rail_clamp_height,lower_bracket_width,rail_clamp_height);
		}
	}
}

module nema_17() {
	union () {
		translate ([0,0,nema17_side/2]) box(nema17_side,nema17_side,nema17_side);
		cylinder (h=nema17_side*1.5,r=23/2,center=true);
		// Flip-out bit needed when building with X vertical
		translate ([nema17_side/2,0,0])  rotate ([0,-45,0]) translate ([nema17_side/2,0,nema17_side/2]) 
			box(nema17_side,nema17_side,nema17_side);
		// 8mm * M3 clearance slots, 4 of.
		rotate ([0,0,45]) translate([19,0,0]) box(8,m3_clearance_rad*2, 60);
		rotate ([0,0,-45]) translate([19,0,0]) box(8,m3_clearance_rad*2, 60);
		rotate ([0,0,135]) translate([19,0,0]) box(8,m3_clearance_rad*2, 60);
		rotate ([0,0,-135]) translate([19,0,0]) box(8,m3_clearance_rad*2, 60);
	}
}

module x_motor_bracket_body() {
	union () {
		translate ([0,0,2])
			difference () {
				// Solid bits.
				union () {
					box(lower_bracket_base_height,lower_bracket_width,lower_bracket_base_width*2);
					translate ([0,-x_rail_sep/2,-1]) rail_clamp();
					translate ([0,x_rail_sep/2,-1]) rail_clamp();
				}
				// Slivers taken off for passage of belt.
				translate ([0,0,-(2*lower_bracket_base_width)]) 
					box(lower_bracket_base_height+0.5,lower_bracket_width+1,lower_bracket_base_width*2);
				translate ([lower_bracket_length+1,4+lower_bracket_width/-2,-(2*lower_bracket_base_width)]) 
					box(lower_bracket_length*2,rail_clamp_width*0.4,lower_bracket_base_width*2);
				translate ([lower_bracket_length+1,-(4+lower_bracket_width/-2),-(2*lower_bracket_base_width)]) 
					box(lower_bracket_length*2,rail_clamp_width*0.4,lower_bracket_base_width*2);
			}
		// Notched box along the top of the bracket.
		translate ([lower_bracket_length-top_notch_height/2,0,0]) difference () {
			box(top_notch_height,lower_bracket_width*0.55,rail_clamp_width*0.8);
			translate ([8.5,0,0]) rotate([0,0,45]) cube((x_rail_sep-rail_clamp_width)*0.4,center=true);
		}
		// "Mouse ears" for fan
		translate ([-lower_bracket_base_height/2,0,lower_bracket_base_width+7]) difference  () {
			union () {
				translate ([0,25,0]) rotate ([0,90,0]) cylinder(h=5,r=7);
				translate ([0,-25,0]) rotate ([0,90,0]) cylinder(h=5,r=7);
			}
			translate ([0,25,0]) rotate ([0,90,0]) m4_hole_vert(30);
			translate ([0,-25,0]) rotate ([0,90,0]) m4_hole_vert(30);
		}
	}
}
module x_motor_bracket () {
	difference () {
		x_motor_bracket_body();
		// Outer bearings
		translate ([0,(lower_bracket_width-12)/2,4-lower_bracket_base_width]) m4_hole_horiz_with_hex(50);
		translate ([0,(lower_bracket_width-12)/-2,4-lower_bracket_base_width]) m4_hole_horiz_with_hex(50);
		// Rails
		translate ([0,x_rail_sep/2,0]) rotate ([0,90,0]) cylinder(h=200,r=m8_tight_rad,center=true);
		translate ([108,(x_rail_sep/2)+12,0]) box(200,40,2);
		translate ([0,-x_rail_sep/2,0]) rotate ([0,90,0]) cylinder(h=200,r=m8_tight_rad,center=true);
		rotate ([180,0,0]) translate ([108,(x_rail_sep/2)+12,0]) box(200,40,2);
		// NEMA17
		translate ([lower_bracket_width*0.35,0,5]) nema_17();
		rotate ([180,0,0]) translate ([lower_bracket_width*0.35,0,6]) nema_17();
		// Holes for rail grips.
		translate ([lower_bracket_length*0.35,x_rail_sep/2+m8_tight_rad*2,-5]) m4_hole_horiz_with_hex(60);
		translate ([lower_bracket_length*0.85,x_rail_sep/2+m8_tight_rad*2,-5]) m4_hole_horiz_with_hex(60);
		translate ([lower_bracket_length*0.35,-(x_rail_sep/2+m8_tight_rad*2),-5]) m4_hole_horiz_with_hex(60);
		translate ([lower_bracket_length*0.85,-(x_rail_sep/2+m8_tight_rad*2),-5]) m4_hole_horiz_with_hex(60);
	}
}

translate ([30,50,0]) rotate ([0,-90,0]) translate([lower_bracket_base_height/2,0,0])
	 x_motor_bracket();


