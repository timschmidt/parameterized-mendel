// 
/*
 *  X Vert Drive Side Plate 360
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
	translate(v=[-27,0,0]) cube(size=[84,34,6]);
}
	translate(v=[5,5,-1]) cylinder(r=2,h=8);
	translate(v=[25,5,-1]) cylinder(r=2,h=8);
	translate(v=[5,17,-1]) cylinder(r=2,h=8);
	translate(v=[25,17,-1]) cylinder(r=2,h=8);
	translate(v=[5.5,28.5,-1]) cylinder(r=2,h=19);
	translate(v=[24.5,28.5,-1]) cylinder(r=2,h=19);

	translate(v=[-4.5,5,-1]) cylinder(r=1.5,h=8);
	translate(v=[-6.5,29.5,-1]) cylinder(r=2,h=8);
	translate(v=[36.5,29.5,-1]) cylinder(r=2,h=8);
	translate(v=[-21.5,29.5,-1]) cylinder(r=2,h=8);
	translate(v=[51.5,29.5,-1]) cylinder(r=2,h=8);

	rotate([90,0,0]) translate(v=[15,17,-35]) cylinder(r=4,h=36);
	rotate([15,0,0]) translate(v=[11.5,0,7]) cube(size=[7,25,8]);

	translate(v=[-28,-1,-1]) cube(size=[19,12,8]);
	translate(v=[34,-1,-1]) cube(size=[24,7,8]);
	translate(v=[-28,-1,-1]) cube(size=[7,24,8]);
	translate(v=[51,-1,-1]) cube(size=[7,24,8]);

	translate(v=[-21,-1,-1]) rotate([0,0,45]) cube(size=[17,17,8]);
	translate(v=[51,-11,-1]) rotate([0,0,45]) cube(size=[24,24,8]);
}
