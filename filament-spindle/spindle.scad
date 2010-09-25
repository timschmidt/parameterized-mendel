/*
 *  Mendel Filament Spindle Include
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

rod_diameter = 8;

module spindle_hole_vert(l) {
	if (rod_diameter == 8) {
		m8_hole_vert(l);
	} else if (rod_diameter == 4) {
		m4_hole_vert(l);
	} else if (rod_diameter == 3) {
		m3_hole_vert(l);
	} else {
		cylinder(l,rod_diameter/2,rod_diameter/2,center=true);
	}
}

module spindle_hole_horiz(l) {
	if (rod_diameter == 8) {
		m8_hole_horiz(l);
	} else if (rod_diameter == 4) {
		m4_hole_horiz(l);
	} else if (rod_diameter == 3) {
		m3_hole_horiz(l);
	} else {
		hole_horiz(rod_diameter, l);
	}
}

module spindle_nut_cavity(l) {
	if (rod_diameter == 8) {
		m8_nut_cavity(l);
	} else if (rod_diameter == 4) {
		m4_nut_cavity(l);
	} else if (rod_diameter == 3) {
		m3_nut_cavity(l);
	} else {
		// FIXME: this is probably wrong...
		hexagon(rod_diameter+5, l);
	}
}
