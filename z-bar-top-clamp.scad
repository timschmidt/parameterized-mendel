// 
/*
 *  Z Bar Top Clamp
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

difference () {
	cube(size=[76,16,10]);
	translate(v=[30,8,-1]) cylinder(r=2,h=12);
	translate(v=[46,8,-1]) cylinder(r=2,h=12);
	translate(v=[8.5,8,-1]) cylinder(r=4,h=12);
	translate(v=[67.5,8,-1]) cylinder(r=4,h=12);
	rotate([90,0,0]) translate(v=[38,10,-17]) cylinder(r=4,h=18);
}