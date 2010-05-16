/*
 *Z Axis motor holder for Mendel
 *  by Vik Olliver. (C) 4-Apr-2010
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

<mendel.inc>
<mendel.conf>

z_motor_bracket_length=80;
z_motor_base_width=nema17_side+12;
z_motor_base_height=13;
z_brace_height=23;

module z_motor_bracket_body() {
	union () {
		// Main boxy bit
		translate ([z_motor_bracket_length/2,0,z_motor_base_height/2])
			box(z_motor_bracket_length,z_motor_base_width,z_motor_base_height);
		// Brace
		translate ([z_motor_bracket_length-21,0,z_brace_height/2]) box(17,z_motor_base_width,z_brace_height);
		// Panel at the back.
		translate ([z_motor_bracket_length-2.5,0,z_brace_height/2]) box(5,z_motor_base_width,z_brace_height);
		// Two blocks over the rear M8 bolt hole
		translate ([z_motor_bracket_length-9,(z_motor_base_width-16)/2,z_brace_height/2])
			difference () {
				box(18,16,z_brace_height);
				translate ([-9,-17,0]) rotate([0,0,45]) box(20,20,3*z_motor_base_height);
			}
		translate ([z_motor_bracket_length-12,-(z_motor_base_width-16)/2,z_brace_height/2])
			difference () {
				box(18,16,z_brace_height);
				translate ([-9,17,0]) rotate([0,0,45]) box(20,20,3*z_motor_base_height);
			}
		// Box to hold rail guide.
		translate ([7,(z_motor_base_width-15)/-2,(z_motor_rail_height+z_motor_base_height+5)/2])
			box(14,15,z_motor_rail_height+z_motor_base_height+5);
	}
}

module z_motor_cutouts () {
	translate ([nema17_side/2+12,0,7]) nema_17();
	// Clip off the two boxes to allow chain/belt to pass.
	translate ([z_motor_bracket_length-33,0,z_motor_base_height*2.4]) rotate ([0,45,0])
		box(z_motor_base_height*2,z_motor_base_width+1,z_motor_base_height*2);
	// Hole for rail guide
	translate ([z_motor_bracket_length-10-z_motor_rail_sep,0,z_motor_base_height-0.5+z_motor_rail_height]) rotate([0,-90,90])
		m4_hole_horiz(z_motor_base_width+10);
}

module z_motor_bracket () {
	difference (){
		union () {
			difference() {
				z_motor_bracket_body();
				z_motor_cutouts ();
			}
			translate ([z_motor_bracket_length-12,(z_motor_base_width-20)/-2,z_brace_height/2])
				box(24,20,z_brace_height);
		}
		// Rear M8 bolt hole
		translate ([z_motor_bracket_length-10,0,z_motor_base_height-0.5]) rotate([0,-90,90])
			m8_hole_horiz(z_motor_base_width+10);
		// Cutout for nut & washers
		translate([z_motor_bracket_length-10,-z_motor_base_width/2,z_motor_base_height-0.5]) {
			rotate ([90,0,0]) cylinder(h=22,r=10,center=true);
			translate([7,0,0]) box(20,22,z_brace_height+4);
		}

	}
}

z_motor_bracket();
