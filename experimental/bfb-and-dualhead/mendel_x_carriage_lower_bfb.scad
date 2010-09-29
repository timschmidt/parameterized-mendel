/*
 * X carriage, lower section for Mendel
 *  by Vik Olliver.  Copyright (C) 2010 vik@diamondage.co.nz
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License, or
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

//rotate([0,0,90]) translate([-49,-54,0.5]) import_stl("x-carriage-lower_1off.stl");

x_car_bottom_height=16.5;
x_car_shelf_width=18;
x_car_lower_width=44;
x_centre_cavity_length=73;
x_centre_cavity_width=25;
x_centre_cavity_height=40;

wing_length=33;
wing_width=10;
wing_height=34.5;

module x_car_lower_block() {
	union () {
		difference () {
			union  (){
				// Main block
				difference () {
					translate ([0,0,x_car_bottom_height/2]) box(x_car_length,x_car_lower_width,x_car_bottom_height);
					translate ([0,x_car_lower_width/-2+9,x_car_bottom_height*1.2]) rotate ([-25,0,0])
						box(x_car_length+2,x_car_shelf_width,x_car_bottom_height);
				}
				// Shelf
				translate ([0,(x_car_lower_width+x_car_shelf_width)/-2,x_car_bottom_height/2]) difference () {
					box(x_car_length,x_car_shelf_width,x_car_bottom_height);
					translate ([0,0,x_car_bottom_height*0.8]) rotate ([25,0,0]) 		
						box(x_car_length+2,x_car_shelf_width*2,x_car_bottom_height);
				}
			}
			translate ([0,x_car_lower_width/-2-3,x_car_bottom_height+2]) rotate ([0,90,0])
				cylinder(h=x_car_length+2,r=7,center=true);
		}
		// WIng
		translate ([5.5,(x_car_lower_width-wing_width)/-2-x_car_shelf_width-2,wing_height/2])
			box(wing_length,wing_width,wing_height);
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
		// Trimming of top edge
		translate ([0,x_car_lower_width/2+1,x_car_bottom_height]) rotate ([0,90,0]) cylinder(h=x_car_length+2,r=3,center=true);
		//space for the belt
		translate ([0,x_car_lower_width/4-0.5,x_car_bottom_height/2+1]) rotate ([0,90,0]) cylinder(h=x_car_length+2,r=3,center=true);	
		translate ([0,x_car_lower_width/4-0.5,x_car_bottom_height/2+6]) rotate ([0,90,0]) cube([10,6,x_car_length+2],center=true);	

		// Horizontal holes in wing. Lower:
		translate([x_car_wing_offset+7,x_centre_cavity_width/-2-8,x_car_bottom_height/2-1]) rotate([90,-90,0])
			m4_hole_horiz_with_hex(50);
		translate([x_car_wing_offset-11.2,x_centre_cavity_width/-2-8,x_car_bottom_height/2-1]) rotate([90,-90,0])
			m4_hole_horiz_with_hex(50);
		// Horizontal holes in wing. Upper
		translate([x_car_wing_offset+7,x_centre_cavity_width/-2-x_car_shelf_width,
			x_car_bottom_height/2-1+x_belt_spacing])
			rotate([90,-90,0]) m4_hole_horiz_with_hex(50);
		translate([x_car_wing_offset-11.2,x_centre_cavity_width/-2-x_car_shelf_width,
			x_car_bottom_height/2-1+x_belt_spacing]) 
			rotate([90,-90,0]) m4_hole_horiz_with_hex(50);
		
		//space for bfb hotend
		translate([x_car_wing_offset,0,0]) rotate([0,0,180]) triangle(42,31);

		// Horizontal axles
		translate ([x_car_bottom_axle_offset+9,x_centre_cavity_width/2+4,x_car_bottom_height/2-1.5])
			rotate ([-90,-90,0]) m4_hole_horiz_with_hex(12);
		translate ([-x_car_bottom_axle_offset-9,x_centre_cavity_width/2+4,x_car_bottom_height/2-1.5])
			rotate ([-90,-90,0]) m4_hole_horiz_with_hex(12);
		// Hole to access extruder nut.
		translate ([x_car_wing_offset,extruder_mount_hole_spacing/-2,15]) scale(1.1) m4_hole_vert_with_hex(30);
		// Angled axes
		translate ([x_car_bottom_axle_offset,x_car_lower_width/-2-2,0]) rotate ([-30,0,0]) m4_hole_vert(40);
		translate ([-x_car_bottom_axle_offset,x_car_lower_width/-2-2,0]) rotate ([-30,0,0]) m4_hole_vert(40);
		translate ([x_car_length/-2+8,(x_car_lower_width+x_car_shelf_width*0.6)/-2+0.5,0]) rotate ([30,0,0])
			m4_hole_vert(40);
		translate ([x_car_length/2-8,(x_car_lower_width+x_car_shelf_width*0.6)/-2+0.5,0]) rotate ([30,0,0])
			m4_hole_vert(40);
	}
}

module triangle(width,height) 
{
	difference() {
		cylinder(r=width/3*sqrt(3)-2,h=height);
		for(i = [0:2])
		{
		rotate([0,0,i*360/3]) 
			translate([width/2+(width/6)*sqrt(3),0,height/2]) cube([width,width,height],center=true);
		}
	}
}

module x_carriage_lower() {
	difference () {
		x_car_lower_block();
		cutouts();
	}
}

x_carriage_lower();
