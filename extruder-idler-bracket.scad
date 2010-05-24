// 
/*
 *  Extruder Idler Block
 *  by Timothy Schmidt.
 *  Modified 19-May-2010 by vik"diamondage.co.nz
 *	Parameterised it to use Mendel includes.
 *	Made it thicker.
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

<mendel.conf>
<mendel.inc>


difference () {
	// Body
	cube(size=[ei_block_wid,ei_block_len,13]);
	// Axle and bearing cavity. Yes, these are not concentric. It gives the bearing room to rotate.
	translate(v=[ei_block_wid/2,ei_block_len/2,13]) rotate([0,90,0]) cylinder(r=m8_tight_rad, h=25,center=true);
	translate(v=[ei_block_wid/2,ei_block_len/2,12]) rotate([0,90,0]) cylinder(r=bearing_608_rad_v+1, h=8.4,center=true);
	// Bolt holes
	#translate(v=[ei_indent,ei_indent,-1]) m4_hole_vert(30);
	translate(v=[ei_block_wid-ei_indent,ei_indent,-1]) m4_hole_vert(30);
	translate(v=[ei_indent,ei_block_len-ei_indent,-1]) m4_hole_vert(30);
	translate(v=[ei_block_wid-ei_indent,ei_block_len-ei_indent,-1]) m4_hole_vert(30);
}
