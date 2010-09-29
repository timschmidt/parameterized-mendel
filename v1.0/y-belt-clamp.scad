// 
/*
 *  OpenSCAD Shapes Library (www.openscad.at)
 *  Foot for Mendel Y platform
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

m4_clearance_rad=2.8;
m6_clearance_rad=3.7;
m8_clearance_rad=4.7;


post_wid=20;

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

clamp_len=35;
clamp_top_len=18;
clamp_base_thick=6;
clamp_height=22;
clamp_thick=30;
clamp_hole_spacing=14;
cutout_size=8;

// The big bit of the clamp.
module clamp_main() {
	difference() {
		union () {
			// Basic T shape
			translate ([0,0,clamp_base_thick/2]) box(clamp_thick,clamp_len,clamp_base_thick);
			translate ([0,0,clamp_height/2]) box(clamp_thick,clamp_top_len,clamp_height);
		}
		// Holes for countersunk screws.
		translate ([clamp_thick/2-5,4-clamp_len/2,-2]) small_woodscrew();
		translate ([5-clamp_thick/2,4-clamp_len/2,-2]) small_woodscrew();
		translate ([5-clamp_thick/2,clamp_len/2-4,-2]) small_woodscrew();
		translate ([clamp_thick/2-5,clamp_len/2-4,-2]) small_woodscrew();
		// Cavities for M4 clamp nuts. Yeah this overhangs. So what? it works.
		translate ([clamp_hole_spacing/2,0,0]) rotate([0,0,30]) hexagon(height=8,depth=(clamp_height-4)*2);
		translate ([-clamp_hole_spacing/2,0,0])  rotate([0,0,30])hexagon(height=8,depth=(clamp_height-4)*2);
		// Cavities for M4 bolts.
		translate ([-clamp_hole_spacing/2,0,0]) m4_hole_vert(clamp_height*3);
		translate ([clamp_hole_spacing/2,0,0]) m4_hole_vert(clamp_height*3);
		// Big hole in case you need to fiddle with your nuts.
		translate ([0,0,cutout_size*0.8+clamp_base_thick]) rotate ([0,45,0]) box(cutout_size,clamp_len,cutout_size);
	}
}

// Little crosspiece of clamp
module clamp_crosspiece() {
	difference() {
		translate ([0,0,clamp_base_thick/2]) box(clamp_thick,clamp_top_len,clamp_base_thick);
		// Cavities for M4 bolts.
		translate ([-clamp_hole_spacing/2,0,0]) m4_hole_vert(clamp_height*3);
		translate ([clamp_hole_spacing/2,0,0]) m4_hole_vert(clamp_height*3);
	}
}

translate ([0,clamp_len/2+5,0]) {
	translate ([clamp_thick*2,0,0]) clamp_crosspiece();
	translate ([clamp_thick*0.5+5,0,0]) clamp_main();
}
