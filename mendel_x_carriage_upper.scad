/*
 * X carriage, upper section for Mendel
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
*/

<mendel_misc.inc>

x_car_top_height=14;
x_car_width=44;
x_top_knob_height=2;
x_top_knob_length=13;
x_centre_cavity_length=73;
x_centre_cavity_width=25;
x_centre_cavity_height=40;

wing_length=33;
wing_width=10;
wing_height=10;

module x_car_top_block() {
	union () {
		translate ([0,0.5,x_car_top_height/2]) box(x_car_length,x_car_width,x_car_top_height);
		// Knobs for mounting bottom of carriage.
		translate([(x_car_length-x_top_knob_length)/2,0,x_car_top_height+x_top_knob_height/2])
			box(x_top_knob_length,x_car_top_knob_width,x_top_knob_height);
		translate([(x_car_length-x_top_knob_length)/-2,0,x_car_top_height+x_top_knob_height/2])
			box(x_top_knob_length,x_car_top_knob_width,x_top_knob_height);
		// WIngs
		translate ([5.5,(wing_width+x_car_width)/2,wing_height/2]) box(wing_length,wing_width,wing_height);
		translate ([8,(wing_width+x_car_width)/-2+1.5,wing_height/2]) difference () {
			box(wing_length,wing_width+1,wing_height);
			translate ([wing_length/2,-wing_width,0]) rotate([0,0,45]) cube(19,center=true);
			translate ([wing_length/-2,-wing_width,0]) rotate([0,0,45]) cube(19,center=true);
		}
	}
}

module cutouts() {
	union () {
		// Hole in da middle
		translate([0,1,10])
			box(x_centre_cavity_length,x_centre_cavity_width,x_centre_cavity_height);
		// Hole to ease extruder fitting
		translate ([x_car_wing_offset,1,10])
			box(extruder_thick+2,x_centre_cavity_width+3,x_centre_cavity_height);
		// Holes at distal X ends.
		x_carriage_common_holes();
		// Trimming of top edges
		translate ([0,x_car_width/2+1,x_car_top_height]) rotate ([0,90,0]) 
			cylinder(h=x_car_length+2,r=4,center=true);
		translate ([0,x_car_width/-2,x_car_top_height]) rotate ([0,90,0]) cylinder(h=x_car_length+2,r=4,center=true);
		// Nut & bolt holes in wings.
		translate ([x_car_wing_offset,extruder_mount_hole_spacing/2,wing_height-4]) rotate([180,0,30])
			m4_hole_vert_with_hex(50);
		translate ([x_car_wing_offset,-extruder_mount_hole_spacing/2,wing_height-4]) rotate([180,0,30]) 
			m4_hole_vert_with_hex(50);
		// Axle holes
		translate([x_car_top_axle_offset,x_centre_cavity_width/-2-4,x_car_top_height/2-1]) rotate([90,-90,0])
			m4_hole_horiz_with_hex(20);
		translate([-x_car_top_axle_offset,x_centre_cavity_width/-2-4,x_car_top_height/2-1]) rotate([90,-90,0])
			m4_hole_horiz_with_hex(20);
		translate([x_car_top_axle_offset,x_centre_cavity_width/2+4,x_car_top_height/2-1]) rotate([-90,-90,0])
			m4_hole_horiz_with_hex(20);
		translate([-x_car_top_axle_offset,x_centre_cavity_width/2+4,x_car_top_height/2-1]) rotate([-90,-90,0])
			m4_hole_horiz_with_hex(20);
		// Horizontal holes in wing
		translate([x_car_wing_offset+7,x_centre_cavity_width/2+6,x_car_top_height/2-1]) rotate([-90,-90,0])
			m4_hole_horiz_with_hex(30);
		translate([x_car_wing_offset-11.2,x_centre_cavity_width/2+6,x_car_top_height/2-1]) rotate([-90,-90,0])
			m4_hole_horiz_with_hex(30);
		// Notches for axles in bottom section.
		translate ([x_car_bottom_axle_offset,x_centre_cavity_width/2-2,0]) rotate ([-17,0,0])
			cylinder(h=50,r=5,center=true);
		translate ([x_car_bottom_axle_offset,x_centre_cavity_width/2,18])
			rotate ([110,0,0]) cylinder(h=21,r=10,center=true);
		translate ([-x_car_bottom_axle_offset,x_centre_cavity_width/2-2,0]) rotate ([-17,0,0])
			cylinder(h=50,r=5,center=true);
		translate ([-x_car_bottom_axle_offset,x_centre_cavity_width/2,18])
			rotate ([110,0,0]) cylinder(h=21,r=10,center=true);
	}
}



module x_carriage_upper() {
	difference () {
		x_car_top_block();
		cutouts();
	}
}

x_carriage_upper();

