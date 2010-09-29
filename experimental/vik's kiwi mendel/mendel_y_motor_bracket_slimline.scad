/*
 *  Slimline Y Motor bracket for Mendel, for use with 608 bearing pulleys
 *  by Vik Olliver.
 *
 * 2010-04-07 vik@diamondage.co.nz
 * Made NEMA17 mount 1mm thicker to allow screws to fit fully into motor housing.
 * Minor tidying of body shape.
 * Adapted to use mendel_misc.inc
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
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
 *
*/

<mendel_misc.inc>

bracket_height=75;
bracket_thickness=18;

module diddy_triangle() {
	difference () {
		box(20,20,35);
		translate ([0,12,0]) rotate ([30,0,0]) box(22,20,55);
	}
}

module y_motor_bracket_body() {
	difference () {
		translate ([0,-5,1]) box(bracket_thickness,105,bracket_height);
		// Big slant
		translate ([0,60,0]) rotate ([30,0,0]) box(30,40,120);
		// Outer corner
		translate ([0,-56,42]) rotate ([40,0,0]) box(30,40,40);
		// Inner corner
		translate ([0,64,-38]) rotate ([45,0,0]) box(30,40,40);
		// Outer lower corner
		translate ([0,-60,-38]) rotate ([-50,0,0]) box(30,40,40);
		// Plastic-saving triangle between frame rods
		translate ([0,24,2]) diddy_triangle();
		// Plastic-saving round hole
		translate ([0,0,-23]) rotate ([0,90,0]) cylinder(h=bracket_thickness+100,r=10, center=true);
	}
}

module y_motor_bracket () {
	difference () {
		y_motor_bracket_body();
		// NEMA17
		translate ([-1,-19,6]) rotate ([-50,0,0]) rotate ([180,90,0]) nema_17();
		// Holes for frame.
		translate ([0,20,0]) rotate ([30,0,0]) {
			translate ([0,0,vertex_m8_sep/2]) rotate ([0,90,0]) m8_hole_vert(50);
			translate ([0,0,-vertex_m8_sep/2]) rotate ([0,90,0]) m8_hole_vert(50);
		}
	}
}

translate ([-bracket_height/2,0,bracket_thickness/2]) rotate ([0,90,0]) translate ([0,0,bracket_height/2])
	 y_motor_bracket();
