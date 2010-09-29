// y-idler remake 
// by Tonokip
// License GPL
// 5-23-2010

$fn=20;

difference()
{
  dxf_linear_extrude(file = "y-idler-bracket-outline.dxf",height=17.511,center=false);
  translate([9.35,66.9057,0]) zhole(8.4);
  translate([19.95,50.5057,0]) zhole(4.4);
  translate([9.35,32.2557,0]) zhole(4.4);
  translate([9.35,8.0057,0]) zhole(8.4);
}

module zhole(diameter) cylinder(h=100,r=(diameter/2),center=true); 