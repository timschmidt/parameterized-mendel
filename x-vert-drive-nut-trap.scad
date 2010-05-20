// 
/*
 *  X Vert Drive Nut Trap
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

// the dimensions on this part aren't exact, it should be printed and tested against the original

<mendel.inc>
<mendel.conf>

difference () {
	cube(size=[21.5,31,8]);
	translate(v=[4.5,5.5,-1]) cylinder(r=2,h=10);
	translate(v=[17,5.5,-1]) cylinder(r=2,h=10);
	translate(v=[4.5,25.5,-1]) cylinder(r=2,h=10);
	translate(v=[17,25.5,-1]) cylinder(r=2,h=10);
	translate(v=[4.5,3.5,-1]) cube(size=[12.5,4,4]);
	translate(v=[4.5,23.5,-1]) cube(size=[12.5,4,4]);
	rotate([90,0,0]) translate(v=[10.75,0,-32]) cylinder(r=4,h=33);
	rotate([90,0,0]) translate(v=[10.75,0,-15.5]) hexagon(12,6);
}