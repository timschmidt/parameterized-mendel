/*
 *  Mendel Filament Spindle Tube Holder 1off
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
include <spindle-tube-fitting.scad>

tube_holder_width = rod_diameter+4; // 18
tube_holder_length = 28; // 41
tube_holder_height = 16; // 25

module tube_holder() {
	difference () {

		// TODO: add a chamfer?
		box(tube_holder_width, tube_holder_length, tube_holder_height);

		// rod hole
		translate([0, -tube_holder_length/2+rod_diameter/2+2, 0]) {
			spindle_hole_vert(tube_holder_height+2);
		}

		// tube fitting
		translate([0, tube_holder_length/2/2/2, 0]) {
			rotate([90, 0, 90]) {
				tube_fitting();
			}
		}
	}
}

translate([0, 0, tube_holder_height/2]) {
	tube_holder();
}
