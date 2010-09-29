// Clamp for holding PCBs to Mendel's board
//
//  GPL V3 Licenced, by Vik Olliver 2010-03-16

<mendel.inc>
<mendel.conf>

clamp_size=14;

difference () {
	translate ([0,0,clamp_size/2]) cube(clamp_size,center=true);
	translate ([clamp_size/2-4,clamp_size*0.3,clamp_size/2]) box(2,clamp_size+1,clamp_size+1);
	translate ([0,0,clamp_size/2]) rotate([0,-90,0]) m4_hole_horiz(clamp_size+2);
}
