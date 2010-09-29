/*
 *  Mendel Filament Spindle Spool Hub 1off
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

spool_hub_height = 5;
spool_hub_diameter = 75;
spool_hub_spoke_width = 20;
spool_hub_spoke_length = 20; // made oversized so that spool ID is adjustable

spool_hub_bolt_diameter = 3; // 4mm would be better, but I only have 3mm at the moment

module spool_hub() {
	difference() {
		cylinder(spool_hub_height,spool_hub_diameter/2,spool_hub_diameter/2,center=true);

		// center hole
		spindle_hole_vert(spool_hub_height+2);

		// left mounting hole
		translate([-rod_diameter, 0, 0]) {
			cylinder(spool_hub_height+2, spool_hub_bolt_diameter/2, spool_hub_bolt_diameter/2, center=true);
		}

		// right mounting hole
		translate([rod_diameter, 0, 0]) {
			cylinder(spool_hub_height+2, spool_hub_bolt_diameter/2, spool_hub_bolt_diameter/2, center=true);
		}

		// back mounting hole
		translate([0, rod_diameter, 0]) {
			cylinder(spool_hub_height+2, spool_hub_bolt_diameter/2, spool_hub_bolt_diameter/2, center=true);
		}

		// front mounting hole
		translate([0, -rod_diameter, 0]) {
			cylinder(spool_hub_height+2, spool_hub_bolt_diameter/2, spool_hub_bolt_diameter/2, center=true);
		}

		// back spoke cutout
		translate([0, spool_hub_diameter/2-spool_hub_spoke_length/2, 0]) {
			box(spool_hub_spoke_width, spool_hub_spoke_length, spool_hub_height+2);
		}

		// front spoke cutout
		translate([0, -spool_hub_diameter/2+spool_hub_spoke_length/2, 0]) {
			box(spool_hub_spoke_width, spool_hub_spoke_length, spool_hub_height+2);
		}

		// left spoke cutout
		translate([-spool_hub_diameter/2+spool_hub_spoke_length/2, 0]) {
			rotate([0, 0, 90]) box(spool_hub_spoke_width, spool_hub_spoke_length, spool_hub_height+2);
		}

		// right spoke cutout
		translate([spool_hub_diameter/2-spool_hub_spoke_length/2, 0, 0]) {
			rotate([0, 0, 90]) box(spool_hub_spoke_width, spool_hub_spoke_length, spool_hub_height+2);
		}

	}
}

translate([0, 0, spool_hub_height/2]) {
	spool_hub();
}

