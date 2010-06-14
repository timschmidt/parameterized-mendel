/*
 *  Mendel Power Bracket (replaces XLR bracket)
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

<mendel.inc>
<mendel.conf>

// side holes on stepper-plate.par (maybe add to mendel.conf?)
mounting_hole_spacing=30;

// XLR or COAX
// if COAX, might want bracket_height to be smaller to reduce uneeded print time
// but you'd need smaller bolts...
type="COAX";

// probably 20 for XLR and 8 for COAX
// might be best to set COAX plug diameter a little small and drill it out later
plug_diameter=8;

bracket_length=40; // 40
bracket_width=20; // 20
bracket_height=25; // 25

module power_plug_bracket() {
	// Main block
	difference () {
		box(bracket_length, bracket_width, bracket_height);

		translate([-mounting_hole_spacing/2, 0, 0]) {
			m4_hole_vert(bracket_height+2);
		}

		translate([mounting_hole_spacing/2, 0, 0]) {
			m4_hole_vert(bracket_height+2);
		}

		if (type=="XLR") {
			xlr_cutout();
		} else {
			coax_cutout();
		}		
	}
}

module xlr_cutout() {
	translate([0, 0, bracket_height/2-plug_diameter/2]) {
		rotate([90,0,0]) {
			cylinder(r=plug_diameter/2, h=bracket_width+2, center=true);
		}

		translate([0, 0, plug_diameter/2]) {
			cube([plug_diameter, bracket_width+2, plug_diameter], center=true);
		}
	}
}

module coax_cutout() {
	//translate([0, 0, bracket_height/2-plug_diameter/2])
	rotate([90,-90,0]) {
		// threaded plug diameter
		hole_horiz(plug_diameter/2,bracket_width);

		// make inside larger for the base
		translate([0, 0, -6]) {
			hole_horiz(plug_diameter/2+3,bracket_width);
		}

		// add a large outside for mounting ring to screw into
		translate([0, 0, bracket_width/2]) {
			hole_horiz(plug_diameter/2+3,4);
		}
	}
}

translate([0, 0, bracket_height/2]) {
	//xlr_cutout();
	//coax_cutout();
	power_plug_bracket();
}
