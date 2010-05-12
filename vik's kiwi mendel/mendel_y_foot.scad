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

module spring() {
	// Chop alternating slices out to make a spring.
	difference () {
		// Spring body
		translate ([0,0,post_wid/2]) cube(post_wid, center=true);
		// Slots in spring
		translate ([-post_wid*0.2,0,post_wid*0.25]) {
			cube([post_wid*1,post_wid*1.1,post_wid*0.15], center=true);
		}
		translate ([post_wid*0.2,0,post_wid*0.5]) {
			cube([post_wid*1,post_wid*1.1,post_wid*0.15], center=true);
		}
		translate ([-post_wid*0.2,0,post_wid*0.75]) {
			cube([post_wid*1,post_wid*1.1,post_wid*0.15], center=true);
		}
	}
}
module post_trimmer () {
	translate ([0,-post_wid,0]) rotate ([30,0,0]) translate ([0,post_wid/2,post_wid/2]) 
		cube(post_wid,center=true);
}
module y_foot_base () {
	scale ([2.5,2.5,1]) difference () {
		translate ([0,0,post_wid/2]) cube(post_wid,center=true);
		post_trimmer(post_wid);
		rotate ([0,0,90]) post_trimmer(post_wid);
		rotate ([0,0,180]) post_trimmer(post_wid);
		rotate ([0,0,270]) post_trimmer(post_wid);
		translate ([0,0,post_wid]) cube(post_wid,center=true);
	}
}


module y_foot_top() {
	difference () {
		translate ([0,0,post_wid*0.15])cube([post_wid*2.1,post_wid,post_wid*0.3],center=true);
		translate ([0,0,post_wid*0.35]) rotate ([90,0,0]) cylinder(r=4, h=80,center=true);
	}
}

module m4_hole_horiz(l) {
	cylinder(l,m4_clearance_rad,m4_clearance_rad,center=true);
	translate ([m4_clearance_rad*0.6,0,0]) rotate ([0,0,45])
		cube([m4_clearance_rad,m4_clearance_rad,l],center=true);
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

// We'll have pan-head screws today please.
screwhead=1;

module y_foot () {
	difference () {
		translate ([0,post_wid/2,0]) difference () {
			union () {
				y_foot_base();
				// Box for nuts to rest on.
				translate([0,0,5]) cube([post_wid*1.6,post_wid,10],center=true);
				translate ([post_wid*1.35,0,post_wid*0.3]) spring();
				translate ([post_wid*-1.35,0,post_wid*0.3])  rotate ([0,0,180]) spring();
				translate ([0,0,post_wid*1.1]) y_foot_top();
			}
			translate ([11,0,0]) rotate ([0,0,90]) m4_hole_horiz(100);
			translate ([-11,0,0]) rotate ([0,0,90]) m4_hole_horiz(100);
			// Holes for heads of screws
			translate ([11,0,0]) rotate([0,0,90]) m8_hole_horiz(l=7);
			translate ([-11,0,0]) rotate([0,0,90]) m8_hole_horiz(l=7);
			// and nut sockets.
			translate ([11,0,post_wid*0.65]) rotate ([0,0,30]) hexagon(height=8.5,depth=10);
			translate ([-11,0,post_wid*0.65]) rotate ([0,0,30]) hexagon(height=8.5,depth=10);
		}
		// Chop off one side to give a flat printing surface.
		translate ([0,-post_wid*1.5,0]) cube(post_wid*3,center=true);
		// Take out holes for small woodscrews.
		translate ([0,post_wid*1.5,-3.5]) small_woodscrew(head=screwhead);
		translate ([post_wid*0.9,post_wid*1.2,-3.5]) small_woodscrew(head=screwhead);
		translate ([-post_wid*0.9,post_wid*1.2,-3.5]) small_woodscrew(head=screwhead);
	}
}
rotate ([90,0,90]) y_foot();
//y_foot();

