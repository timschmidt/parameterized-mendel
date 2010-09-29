// 
/*
 *  X Vert Drive Side Plate 180
 *  by Timothy Schmidt.
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

<mendel.inc>
<mendel.conf>

difference () {
union () {
	translate(v=[12.5,0,5]) cube(size=[5,24,8]);
	translate(v=[0,23,5]) cube(size=[30,11,12]);
	cube(size=[30,34,6]);
}
	translate(v=[5,5,-1]) cylinder(r=2,h=10);
	translate(v=[25,5,-1]) cylinder(r=2,h=10);
	translate(v=[5,17,-1]) cylinder(r=2,h=10);
	translate(v=[25,17,-1]) cylinder(r=2,h=10);
	translate(v=[5.5,28.5,-1]) cylinder(r=2,h=19);
	translate(v=[24.5,28.5,-1]) cylinder(r=2,h=19);
	rotate([90,0,0]) translate(v=[15,17,-35]) cylinder(r=4,h=36);
	rotate([15,0,0]) translate(v=[11.5,0,7]) cube(size=[7,25,8]);
}
