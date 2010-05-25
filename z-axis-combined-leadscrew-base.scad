/*
 *Z Axis leadscrew bearing holder WITH MOTOR for Mendel
 *   Based on "Z Axis leadscrew bearing holder for Mendel" by Vik Olliver. (C) 4-Apr-2010
 * Nicholas C Lewis  May 24, 2010
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

//translate([-4.5,-36.4,0]) import_stl("z-leadscrew-base_2off.stl");

leadscrew_base_length=82;
leadscrew_base_width=60;
leadscrew_base_height=17;
z_slider_grip_length=10;
z_slider_grip_width=34;
z_slider_grip_height=20;
z_slider_rad=4.3;
z_bearing_inset=29;
bearing_608_rad=11;

module z_leadscrew_body() {
	hollow_len=leadscrew_base_length-5-z_slider_grip_length;
	union () {
		// Main boxy bit
		difference () {
			translate ([leadscrew_base_length/2,0,leadscrew_base_height/2])
				box (leadscrew_base_length,leadscrew_base_width,leadscrew_base_height);
			// Hollow in the centre of the bracket
			translate ([z_slider_grip_length+hollow_len/2-0.1,0,leadscrew_base_height/2+8])
				box(hollow_len,leadscrew_base_width-26,leadscrew_base_height);
		}
		// Bit gripping Z guide rod
		translate([z_slider_grip_length/2,0,z_slider_grip_height/2])
			 box(z_slider_grip_length,z_slider_grip_width,z_slider_grip_height);
		// Brace with Z sensor support holes in.
		translate ([leadscrew_base_length-21,0,11]) box(17,leadscrew_base_width,22);
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
}


module z_leadscrew_cutouts () {
	// Z Slider grip
	cylinder(h=leadscrew_base_height*4,r=z_slider_rad-0.2,center=true);
	// 608 bearing
	translate([z_bearing_inset,0,0]) cylinder(h=leadscrew_base_height*4,r=bearing_608_rad,center=true);
	// Long M8 bolt holes
	translate ([leadscrew_base_length/2,leadscrew_base_width/2-8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	translate ([leadscrew_base_length/2,-leadscrew_base_width/2+8,leadscrew_base_height/2]) rotate ([0,-90,0])
		m8_hole_horiz(leadscrew_base_length*2);
	// Rear M8 bolt hole
	translate ([leadscrew_base_length-10,0,leadscrew_base_height-0.5]) rotate([0,-90,90])
		m8_hole_horiz(leadscrew_base_width+10);
	translate ([z_bearing_inset,0,0]) {
		translate ([-m4_clearance_rad_v-bearing_608_rad,0,0]) m4_hole_vert(leadscrew_base_height);
		rotate ([0,0,60]) translate ([bearing_608_rad+m4_clearance_rad_v,0,0])
			m4_hole_vert(leadscrew_base_height);
		rotate ([0,0,-60]) translate ([bearing_608_rad+m4_clearance_rad_v,0,0])
			m4_hole_vert(leadscrew_base_height);
	}
	// Z clamp bolt holes
	translate ([7,7,11.5]) rotate ([0,-90,0]) m4_hole_horiz_with_hex(20);
	translate ([7,-7,11.5]) rotate ([0,-90,0]) m4_hole_horiz_with_hex(20);
	// Z limit switch holes
	translate ([58,0,3]) rotate ([0,180,0]) m4_hole_vert_with_hex(leadscrew_base_height*3);
	translate ([60,11.5,3]) m4_hole_vert(leadscrew_base_height*3);
	translate ([60,-11.5,3]) m4_hole_vert(leadscrew_base_height*3);
}

module z_leadscrew_base () {
	difference() {
		z_leadscrew_body();
		z_leadscrew_cutouts ();
	}
}

module zmotor(){
	difference()
	{
		union()
		{
			cube(size=[69,18,25]);
			cube(size=[69,60,17]);
		}
		translate([40,10,16])
			rotate([90,-90,90])	
				m8_hole_horiz(100);
		translate([16,5,5])
			cube(size=[37,13,20]);
		translate([22,39,0])
			cylinder(h=18,r=11);
		translate([47,39,0])
			cylinder(h=18,r=11);
		translate([20,28,0])
			cube(size=[31-3,22,18]);
		translate([5,22,0])
			cube(size=[31-3,3,18]);
		translate([36,22,0])
			cube(size=[31-3,3,18]);
		translate([5,53,0])
			cube(size=[31-3,3,18]);
		translate([36,53,0])
			cube(size=[31-3,3,18]);
	
	}
}

union()
{
	z_leadscrew_base();
	translate([82,29,0])
		rotate([0,0,90])
			zmotor();
	translate([25,70,0])
	rotate([0,0,-120])	
		intersection()
		{
			cube(size=[60,60,12]);
			rotate([0,0,-60])	
				cube(size=[40,40,20]);
		}
}