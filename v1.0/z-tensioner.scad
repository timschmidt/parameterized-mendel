/*
 *Z Tensioner for Mendel
 *  by Vik Olliver. (C) 4-Apr-2010
 *  modified by Timothy Schmidt
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

leadscrew_base_length=40;
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
		translate ([leadscrew_base_length/2,0,leadscrew_base_height/2])
			box (leadscrew_base_length,leadscrew_base_width,leadscrew_base_height);
		// Panel at the back.
		translate ([leadscrew_base_length-2.5,0,11]) box(5,leadscrew_base_width,22);
		// Two blocks over the rear M8 bolt hole
		translate ([leadscrew_base_length-9,(leadscrew_base_width-16)/2,(leadscrew_base_height+8)/2])
			box(18,16,leadscrew_base_height+8);
		translate ([leadscrew_base_length-9,-(leadscrew_base_width-16)/2,(leadscrew_base_height+8)/2])
			box(18,16,leadscrew_base_height+8);
		// Lip for tensioner mount
		translate ([11,0,20])
			box(14,leadscrew_base_width-16,7);
	}
}


module z_leadscrew_cutouts () {
	// Long M8 bolt holes
	translate ([leadscrew_base_length/2,leadscrew_base_width/2-8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	translate ([leadscrew_base_length/2,-leadscrew_base_width/2+8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	// Recesses for nuts
	translate ([-2,leadscrew_base_width/2-8,leadscrew_base_height/2]) rotate ([0,90,0])
		cylinder(h=12,r=11,center=true);
	translate ([-2,leadscrew_base_width/2,leadscrew_base_height/2])
		box(12,12,leadscrew_base_height+1);
	translate ([-2,leadscrew_base_width/-2+8,leadscrew_base_height/2]) rotate ([0,90,0])
		cylinder(h=12,r=11,center=true);
	translate ([-2,-leadscrew_base_width/2,leadscrew_base_height/2])
		box(12,12,leadscrew_base_height+1);
	// Rear M8 bolt hole
	translate ([leadscrew_base_length-10,0,leadscrew_base_height-0.5]) rotate([0,-90,90])
		m8_hole_horiz(leadscrew_base_width+10);
	// Mounting hole for bearing
	translate ([11,0,12])
		box(4, leadscrew_base_width-16-z_guide_bar_rad*2, leadscrew_base_height+10);
}

module z_leadscrew_base () {
	difference() {
		z_leadscrew_body();
		z_leadscrew_cutouts ();
	}
}


z_leadscrew_base();
