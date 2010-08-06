/*
 *  Mendel Filament Spindle Corner Bracket 8off
 *  by Tony Buser <tbuser@gmail.com>
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

include <../mendel.inc>
include <../mendel.conf>

include <spindle.scad>

corner_bracket_width = 28;
corner_bracket_length = 28;
corner_bracket_height = 33;

module corner_bracket() {
	difference () {

		// TODO: chamfer?
		box(corner_bracket_width, corner_bracket_length, corner_bracket_height);

		// bottom side hole
		translate([-corner_bracket_width/2+rod_diameter-1, 0, -corner_bracket_height/2+rod_diameter-1]) {
			rotate([0, -90, 90]) {
				spindle_hole_horiz(corner_bracket_length+2);
			}
		}

		// left mid hole
		translate([0, corner_bracket_length/2-rod_diameter+1, 0]) {
			rotate([-90, -90, -90]) {
				spindle_hole_horiz(corner_bracket_width+2);
			}
		}

		// right mid hole
		translate([0, -corner_bracket_length/2+rod_diameter-1, 0]) {
			rotate([-90, -90, -90]) {
				spindle_hole_horiz(corner_bracket_width+2);
			}
		}

		// left vert hole
		translate([corner_bracket_width/2-rod_diameter-1, corner_bracket_length/2-rod_diameter, 0]) {
			spindle_hole_vert(corner_bracket_height+2);

			translate([0, 0, corner_bracket_width/2-2]) {
				spindle_nut_cavity(rod_diameter+2);
			}
		}

		// right vert hole
		translate([corner_bracket_width/2-rod_diameter-1, -corner_bracket_length/2+rod_diameter, 0]) {
			spindle_hole_vert(corner_bracket_height+2);

			translate([0, 0, corner_bracket_width/2-2]) {
				spindle_nut_cavity(rod_diameter+2);
			}
		}
		

		/*
		translate([0, -corner_bracket_length/2+3-1, corner_bracket_height/2-rod_diameter+1]) {
			// top side cutout
			translate([0, 0, rod_diameter/2]) box(rod_diameter, rod_diameter-1, rod_diameter);

			rotate([90, 0, 0]) {
				spindle_nut_cavity(rod_diameter-1);
			}
		}
		*/
	}
}

translate([0, 0, corner_bracket_height/2]) {
	corner_bracket();
}
