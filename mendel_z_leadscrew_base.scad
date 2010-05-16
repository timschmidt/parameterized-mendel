/*
 *Z Axis leadscrew bearing holder for Mendel
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

leadscrew_base_length=82;
leadscrew_base_width=60;
z_slider_grip_length=11;
z_slider_grip_width=34;
z_slider_grip_height=20;
z_guide_bar_rad=4.3;
z_bearing_inset=33;

module z_leadscrew_body() {
	hollow_len=leadscrew_base_length-5-z_slider_grip_length;
	union () {
		// Main boxy bit
		difference () {
			translate ([leadscrew_base_length/2,0,leadscrew_base_height/2])
				box (leadscrew_base_length,leadscrew_base_width,leadscrew_base_height);
			// Hollow in the centre of the bracket
			translate ([z_slider_grip_length+hollow_len/2-0.1,0,leadscrew_base_height/2+8])
				box(hollow_len,leadscrew_base_width-27,leadscrew_base_height+0.1);
		}
		// Bit gripping Z guide rod
		translate([z_slider_grip_length/2,0,z_slider_grip_height/2])
			 box(z_slider_grip_length,z_slider_grip_width,z_slider_grip_height);
		// Brace in the middle
		translate ([leadscrew_base_length-21,0,11]) box(15,leadscrew_base_width,22);
		// Panel at the back.
		translate ([leadscrew_base_length-2.5,0,11]) box(5,leadscrew_base_width,22);
		// Two blocks over the rear M8 bolt hole
		translate ([leadscrew_base_length-9,(leadscrew_base_width-16)/2,(leadscrew_base_height+8)/2])
			difference () {
				box(18,16,leadscrew_base_height+8);
				translate ([-9,-17,0]) rotate([0,0,45]) box(20,20,3*leadscrew_base_height);
			}
		translate ([leadscrew_base_length-9,-(leadscrew_base_width-16)/2,(leadscrew_base_height+8)/2])
			difference () {
				box(18,16,leadscrew_base_height+8);
				translate ([-9,17,0]) rotate([0,0,45]) box(20,20,3*leadscrew_base_height);
			}
	}
	// Box to hold rail guide.
	translate ([leadscrew_base_length-10-z_motor_rail_sep+2,(leadscrew_base_width-15)/2,(z_motor_rail_height+24)/2])
		box(16,15,z_motor_rail_height+24);
}


module z_leadscrew_cutouts () {
	// Z Guide bar grip
	cylinder(h=leadscrew_base_height*4,r=z_guide_bar_rad-0.2,center=true);
	// 608 bearing
	translate([z_bearing_inset,0,0]) cylinder(h=leadscrew_base_height*4,r=bearing_608_rad_v,center=true);
	// Long M8 bolt holes
	translate ([leadscrew_base_length/2,leadscrew_base_width/2-8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	translate ([leadscrew_base_length/2,-leadscrew_base_width/2+8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	// Recesses for nuts
	translate ([0,leadscrew_base_width/2-8,leadscrew_base_height/2]) rotate ([0,90,0])
		cylinder(h=12,r=11,center=true);
	translate ([0,leadscrew_base_width/2,leadscrew_base_height/2])
		box(12,12,leadscrew_base_height+1);
	translate ([0,leadscrew_base_width/-2+8,leadscrew_base_height/2]) rotate ([0,90,0])
		cylinder(h=12,r=11,center=true);
	translate ([0,-leadscrew_base_width/2,leadscrew_base_height/2])
		box(12,12,leadscrew_base_height+1);
	// Rear M8 bolt hole
	translate ([leadscrew_base_length-10,0,leadscrew_base_height-0.5]) rotate([0,-90,90])
		m8_hole_horiz(leadscrew_base_width+10);
	translate ([z_bearing_inset,0,0]) {
		translate ([-m4_clearance_rad_v-bearing_608_rad_v,0,0]) m4_hole_vert(leadscrew_base_height);
		translate ([-bearing_608_rad_v,0,0]) box(6,m4_clearance_rad_v*2,leadscrew_base_height);
		rotate ([0,0,60]) translate ([bearing_608_rad_v+m4_clearance_rad_v,0,0]) {
			m4_hole_vert(leadscrew_base_height);
			translate ([-m4_clearance_rad_v,0,0])
				box(6,m4_clearance_rad_v*2,leadscrew_base_height);
		}
		rotate ([0,0,-60]) translate ([bearing_608_rad_v+m4_clearance_rad_v,0,0]) {
			m4_hole_vert(leadscrew_base_height);
			translate ([-m4_clearance_rad_v,0,0])
				box(6,m4_clearance_rad_v*2,leadscrew_base_height);
		}
	}
	// Z clamp bolt holes
	translate ([7,7,11.5]) rotate ([0,-90,0]) m4_hole_horiz_with_hex(20);
	translate ([7,-7,11.5]) rotate ([0,-90,0]) m4_hole_horiz_with_hex(20);
	// Slider bolt hole for tensioning.
	translate ([leadscrew_base_length-10-z_motor_rail_sep,(leadscrew_base_width)/2-6,leadscrew_base_height-0.5+z_motor_rail_height]) rotate([0,-90,90])
		m4_hole_horiz_with_hex(leadscrew_base_width+10);

}

module z_leadscrew_base () {
	difference() {
		z_leadscrew_body();
		z_leadscrew_cutouts ();
	}
}


z_leadscrew_base();
