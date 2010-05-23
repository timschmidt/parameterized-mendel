// Tonokip remake of x360zbearing
// License GPL
// 5-23-2010

$fn = 12;

difference()
{
  union()
  {
    dxf_linear_extrude(file = "x-360-z-bearing-plate-bottom-outline.dxf",height=12,center=false);
    dxf_linear_extrude(file = "x-360-z-bearing-plate-top-outline.dxf",height=(25),center=false);
  }

  translate([0,36.909,4.615]) xteardrop(4,200);
  translate([0,36.909,19.385]) xteardrop(4,200);
  translate([0,55.679,6.937]) xteardrop(4,200);
  translate([44.2302,49.714,19.621]) rotate(50,[0,0,1]) xteardrop(4,200);

}

module xteardrop(diameter,length) rotate(a=-90,v=[0,1,0]) rotate(a=-90,v=[0,0,1]) zteardrop(diameter,length);

module zteardrop(diameter,height)
{
  rotate(a=45, v=[0,0,1]) union()
  {
    translate([0,0,-height/2]) cube(size=[diameter/2,diameter/2,height],center=false);
    cylinder(r=diameter/2, h = height,center=true);
  }
}