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

// Everything in this part needs to be manually rotated about the X axis 180 degrees, then the rotate statement removed.

$fn=50;
module main()
{
	module spur()
	{
		linear_extrude(height=7) polygon([[-1,-1],[-1,1],[0.7,0.7],[0.7,-0.7]],[[0,1,2,3,0]]);
	}
	
 difference()
 {	 
 	union()
 	{
 		//base
 		rotate_extrude()
 		{
 				square([11,8]);
 		}
    	
    	//shaft
    	translate([0,0,11])cylinder(r=14.5,h=7);

	//bottom belt guide
	translate([0,0,18])cylinder(r=18,h=1);

	//top belt guide
	difference(){
		translate([0,0,8])cylinder(r=18,h=3);
	rotate_extrude() {
		translate([19,7.5,11]){
			rotate([0,0,45])square([4.7,4.7]);
		}
	}
	}
    	
    	//spurs
    	for(i=[1:20]) rotate([0,0,i*(360/20)])
    	translate([15,0,11])spur();
   }
   
   //shaft hole
    translate([0,0,-1])cylinder(r=4,h=22);
    		
    //captive nut and grub holes
    for(j=[1:3]) rotate([0,0,j*(360/3)])
	translate([0,20,4])rotate([90,0,0])
	union()
	{
		//enterance
		translate([0,-3,13]) cube([5.4,6,2.4],center=true);
		//nut
		translate([0,0,11.8]) rotate([0,0,30])cylinder(r=3.12,h=2.4,$fn=6);
		//grub hole
		translate([0,0,7]) cylinder(r=1.5,h=15);
	}

 }

   
}

rotate([180,0,0]){
	main();
}