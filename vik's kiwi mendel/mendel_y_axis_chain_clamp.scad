// Clamp for holding belts to Mendel's deposition bed
//
//  GPL V3 Licenced, by Vik Olliver 2010-03-16

<mendel_misc.inc>

clamp_length=30;
clamp_width=10;
clamp_height=6;

module clamp() {
	difference () {
		translate ([0,0,clamp_height/2]) box(clamp_length,clamp_width,clamp_height);
		translate ([10,0,-3]) small_woodscrew();
		translate ([-10,0,-3]) small_woodscrew();
		// 3.5mm chain holder
		translate ([0,0,clamp_height]) rotate ([90,0,0]) cylinder(h=clamp_width*2,r=1.65,center=true);
		// Lop off corners
		translate ([clamp_length*0.65,clamp_width*0.52,clamp_width/4]) rotate ([0,0,45]) cube(clamp_width,center=true);
		translate ([clamp_length*-0.65,clamp_width*0.52,clamp_width/4]) rotate ([0,0,45]) cube(clamp_width,center=true);
		translate ([clamp_length*0.65,clamp_width*-0.52,clamp_width/4]) rotate ([0,0,45]) cube(clamp_width,center=true);
		translate ([clamp_length*-0.65,clamp_width*-0.52,clamp_width/4]) rotate ([0,0,45]) cube(clamp_width,center=true);
	}
}

clamp();