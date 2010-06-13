// x-bar-clamp-m4 remake in OpenSCAD
// by tonokip
// License GPL
// May 29, 2010

clamp_vM8=8;
hM4=4;

length=30;
width=14;
height=11;

$fn=20;

module xhole(diameter) rotate(a=90,v=[0,1,0]) zhole(diameter); 
module yhole(diameter) rotate(a=90,v=[1,0,0]) zhole(diameter); 
module zhole(diameter) cylinder(h=200,r=(diameter/2),center=true); 

module xteardrop(diameter,length) rotate(a=-90,v=[0,1,0]) rotate(a=-90,v=[0,0,1]) zteardrop(diameter,length);

module yteardrop(diameter,length) rotate(a=90,v=[1,0,0]) zteardrop(diameter,length);

module zteardrop(diameter,height)
{
	rotate(a=45, v=[0,0,1]) union()
	{
		translate([0,0,-height/2]) cube(size=[diameter/2,diameter/2,height],center=false);
		cylinder(r=diameter/2, h = height,center=true);
	}
}

translate([0,0,height/2])  //Start part at Z=0
difference()
{
	//Main block
	round_cube(length,width,height,radius=1,FN=3);

	//Indent
	translate([0,-width/2+3/2-0.001,0]) round_indent(10,3,11+1,radius=1,FN=3);
	//translate([0,-width/2,0]) cube([10,3*2,11+1],center=true); //Non rounded indent

	// Horizontal M4
	translate([-9.5,0,0]) yteardrop(hM4,100);
	translate([ 9.5,0,0]) yteardrop(hM4,100);

	// Clamp hole
	translate([0,width/2,0]) zhole(clamp_vM8);
}



module round_cube(length,width,height,radius,FN=10)
{
	difference()
	{
		cube([length,width,height],center=true);
		translate([ length/2, width/2,0]) round_corner(radius=radius,height=height+1,FN=FN);
		translate([-length/2, width/2,0]) zrot(90) round_corner(radius=radius,height=height+1,FN=FN);
		translate([-length/2,-width/2,0]) zrot(90*2) round_corner(radius=radius,height=height+1,FN=FN);
		translate([ length/2,-width/2,0]) zrot(90*3) round_corner(radius=radius,height=height+1,FN=FN);
	}
}

module round_indent(length,width,height,radius,FN=10)
{
	difference()
	{
		cube([length,width,height],center=true);
		translate([ length/2, width/2,0]) round_corner(radius=radius,height=height+1,FN=FN);
		translate([-length/2, width/2,0]) zrot(90) round_corner(radius=radius,height=height+1,FN=FN);
	}
	translate([ length/2,-width/2,0]) zrot(90*2) round_corner(radius=radius,height=height,FN=FN);
	translate([-length/2,-width/2,0]) zrot(90*3) round_corner(radius=radius,height=height,FN=FN);
}

module round_corner(radius,height,FN=10)
{
	if(FN > 0)
	{
		difference()
		{
			translate([-radius/2+0.001,-radius/2+0.001,0]) cube([radius,radius,height],center=true);
			translate([-radius,-radius,0]) cylinder(r=radius,h=height+1,center=true,$fn=FN*4);
		}
	}
}

module zrot(deg)
{
	rotate(a=deg,v=[0,0,1]) child(0);
}
