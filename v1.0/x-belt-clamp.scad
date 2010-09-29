/*
 * X carriage belt clamps for Mendel
 *  by Vik Olliver.  Copyright (C) 2010 vik@diamondage.co.nz
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

wing_height=34.5+1;
x_belt_clamp_thick=10;
x_belt_clamp_width=10;

module x_belt_clamp () {
	// Main block
	difference () {
		translate ([0,0,x_belt_clamp_thick/2])
			box(wing_height,x_belt_clamp_width,x_belt_clamp_thick);
		translate ([x_belt_spacing/2,0,0])
			m4_hole_vert(40);
		translate ([x_belt_spacing/-2,0,0])
			m4_hole_vert(40);
	}
}


x_belt_clamp();
