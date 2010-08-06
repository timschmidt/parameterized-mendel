/*
 *  Mendel Filament Spindle Tube Fitting
 *  DO NOT PRINT THIS - it's just used to cut out a mounting hole in the tube holder
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

tube_fitting_height = 20;

tube_fitting_exit_diameter = 10.7;
tube_fitting_exit_height = 8;

tube_fitting_entry_diameter = 10.6;

tube_fitting_inside_nut_height = 11.2;
//tube_fitting_inside_nut_depth = 4.7;
tube_fitting_inside_nut_depth = tube_fitting_height/2+2.5;

tube_fitting_outside_nut_height = 16.2;
tube_fitting_outside_nut_depth = 3.4;

module tube_fitting() {
	union() {

		// smaller diameter entry side
		//cylinder(tube_fitting_height, tube_fitting_entry_diameter/2, tube_fitting_entry_diameter/2, center=true);
		rotate([0,0,90]) {
			hole_horiz(tube_fitting_entry_diameter/2, tube_fitting_height);
		}

		// exit side
		/*
		translate([0, 0, -tube_fitting_height/2+tube_fitting_exit_height/2]) {
			cylinder(tube_fitting_exit_height, tube_fitting_exit_diameter/2, tube_fitting_exit_diameter/2, center=true);
		}
		*/

		// inside nut
		translate([0, 0, -tube_fitting_height/2+tube_fitting_inside_nut_depth/2]) {
			hexagon(tube_fitting_inside_nut_height, tube_fitting_inside_nut_depth);
		}

		// outside mounting nut
		translate([0, 0, tube_fitting_height/2-tube_fitting_outside_nut_depth/2]) {
			hexagon(tube_fitting_outside_nut_height, tube_fitting_outside_nut_depth);
		}
	}
}

//tube_fitting();