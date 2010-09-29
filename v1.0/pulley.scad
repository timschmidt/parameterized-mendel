/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

$fn=50;
module main()
{
	module spur()
	{
		linear_extrude(height=20) polygon([[-1,-1],[-1,1],[0.7,0.7],[0.7,-0.7]],[[0,1,2,3,0]]);
	}
	
 difference()
 {	 
 	union()
 	{
 		//base
 		rotate_extrude()
 		{
 				square([9,8]);
 				square([10,7]);
 				translate([9,7]) circle(1);
 		}
    	
    	//shaft
    	cylinder(r=5,h=20);
    	
    	//spurs
    	for(i=[1:8]) rotate([0,0,i*(360/8)])
    	translate([5.5,0,0])spur();
   }
   
   //shaft hole
    translate([0,0,-1])cylinder(r=2.5,h=22);
    		
    //captive nut and grub holes
    for(j=[1:3]) rotate([0,0,j*(360/3)])
	translate([0,20,4])rotate([90,0,0])
	union()
	{
		//enterance
		translate([0,-3,14.5]) cube([5.4,6,2.4],center=true);
		//nut
		translate([0,0,13.3]) rotate([0,0,30])cylinder(r=3.12,h=2.4,$fn=6);
		//grub hole
		translate([0,0,9]) cylinder(r=1.5,h=10);
	}

 }

   
}

main();
