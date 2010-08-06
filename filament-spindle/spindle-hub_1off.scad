/*
 *  Mendel Filament Spindle Hub 1off
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

hub_width = 40;
hub_length = 40;
hub_height = 33;

module hub() {
	difference () {

		// base shape box and a crude chamfer
		intersection() {
			box(hub_width, hub_length, hub_height);
			cylinder(hub_height+2, hub_width/2+3.5, hub_width/2+3.5, center=true);
		}

		// center rod and bearing support
		cylinder(hub_height+2, bearing_608_rad_h-2, bearing_608_rad_h-2, center=true);
		translate([0, 0, hub_height/2-(bearing_608_len+6)/2+1]) {
			cylinder((bearing_608_len+6)+1, bearing_608_rad_h, bearing_608_rad_h, center=true);
		}

		// left nut
		translate([-hub_width/2+3-1, 0, hub_height/2-rod_diameter+1]) {
			rotate([0, -90, 0]) {
				spindle_hole_horiz(rod_diameter+2);
			}
			rotate([90, 0, 90]) {
				spindle_nut_cavity(rod_diameter-1);
			}
		}

		// right nut
		translate([+hub_width/2-3+1, 0, hub_height/2-rod_diameter+1]) {
			rotate([0, -90, 0]) {
				spindle_hole_horiz(rod_diameter+2);
			}
			rotate([90, 0, 90]) {
				spindle_nut_cavity(rod_diameter-1);
			}
		}

		// front nut
		translate([0, -hub_width/2+3-1, hub_height/2-rod_diameter+1]) {
			rotate([0, -90, 90]) {
				spindle_hole_horiz(rod_diameter+2);
			}
			rotate([90, 0, 0]) {
				spindle_nut_cavity(rod_diameter-1);
			}
		}

		// back nut
		translate([0, +hub_width/2-3+1, hub_height/2-rod_diameter+1]) {
			rotate([0, -90, 90]) {
				spindle_hole_horiz(rod_diameter+2);
			}
			rotate([90, 0, 0]) {
				spindle_nut_cavity(rod_diameter-1);
			}
		}

		// left support rod
		translate([-hub_width/2+rod_diameter, 0, -hub_height/2+rod_diameter]) {
			rotate([90, -90, 0]) {
				spindle_hole_horiz(hub_length+2);
			}
		}

		// right support rod
		translate([hub_width/2-rod_diameter, 0, -hub_height/2+rod_diameter]) {
			rotate([90, -90, 0]) {
				spindle_hole_horiz(hub_length+2);
			}
		}
	}
}

translate([0, 0, hub_height/2]) {
	hub();
}
