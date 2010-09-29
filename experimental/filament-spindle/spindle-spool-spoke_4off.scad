/*
 *  Mendel Filament Spindle Spool Spokes 4off
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

spool_spoke_height = 90;
spool_spoke_width = 20;
spool_spoke_length = 5; // thickness

spool_spoke_mount_inset = spool_spoke_length+10;
spool_spoke_mount_inset = 20;

spool_spoke_hub_inset = 25;

module spool_spoke() {
	union() {

		difference() {
			box(spool_spoke_width, spool_spoke_length, spool_spoke_height);

			// create an inside perimeter so that raftless plugin doesn't screw up 	infill
			translate([0,0,-spool_spoke_height/2/2]) {
				box(spool_spoke_width/2/2, spool_spoke_length+2, spool_spoke_height/2/2);
			}
		}

		// top
		translate([0, -spool_spoke_hub_inset/2+spool_spoke_length/2, spool_spoke_height/2-spool_spoke_length/2]) {
			box(spool_spoke_width, spool_spoke_hub_inset, spool_spoke_length);
		}

		// reinforcement TODO: make fully parametric
		polyhedron(points=[[-2.5, -2.5, 0],[2.5, -2.5, 0],[-2.5, -spool_spoke_hub_inset+spool_spoke_length, 45],[2.5, -spool_spoke_hub_inset+spool_spoke_length, 45],[-2.5, 0, 45],[2.5, 0, 45]], triangles=[[0, 3, 1],[3,0,2],[1,3,5],[4,2,0],[0,5,4],[0,1,5],[5,2,4],[5,3,2]]);

		// base
		difference() {
			translate([0, -spool_spoke_mount_inset/2+spool_spoke_length/2, -spool_spoke_height/2+spool_spoke_length/2]) {
				box(spool_spoke_width, spool_spoke_mount_inset, spool_spoke_length);
			}

			// mounting bolt
			translate([0, -spool_spoke_mount_inset/2+spool_spoke_length/2-spool_spoke_length/2, -spool_spoke_height/2+spool_spoke_length/2]) {
				rotate([0, 0, -90]) hole_horiz(3, spool_spoke_length+2);
			}
		}
	}
}

//spool_spoke();

rotate([-90,0,-90]) {
	translate([0,-spool_spoke_length/2,0]) spool_spoke();
}
