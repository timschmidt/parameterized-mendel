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

//Corner cuts added by Tonokip

//<tonokip.inc>

module yhole(diameter) rotate(a=90,v=[1,0,0]) zhole(diameter); 
module zhole(diameter) cylinder(h=200,r=(diameter/2),center=true);

vM8=9;
vM4=5;

hM8=8.1;

width=16;
length=76;
height=10;

translate([0,0,height/2]) //Reposition Z
difference ()
{
	//Main Block
	cube(size=[length,width,height],center=true);

	//M4
	translate(v=[8,0,0]) zhole(vM4);
	translate(v=[-8,0,0]) zhole(vM4);

	//M8
	translate(v=[29.5,0,0]) zhole(vM8);
	translate(v=[-29.5,0,0]) zhole(vM8);

	//Clamped Hole
	translate([0,0,height/2]) yhole(hM8);

	//Corner cuts
	translate([-length/2, 11,0]) rotate(45, [0,0,1]) cube([10,10,100],center=true);
	translate([-length/2,-11,0]) rotate(45, [0,0,1]) cube([10,10,100],center=true);
	translate([ length/2, 11,0]) rotate(45, [0,0,1]) cube([10,10,100],center=true);
	translate([ length/2,-11,0]) rotate(45, [0,0,1]) cube([10,10,100],center=true);
}
