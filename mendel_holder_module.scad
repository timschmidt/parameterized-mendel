// Module that attaches to Mendel's frame and holds PCBs
//
//  GPL V3 Licenced, by Vik Olliver 2010-03-16

<mendel_misc.inc>

holder_length=96;
holder_width=96;
holder_height=12;
holder_foot_height=14;	// Bit that rests on threaded rod.
frame_width=5;
crosspiece_width=m4_clearance_rad_v*4.5;
crosspiece_height=5;

module crosspiece(len) {
	translate ([0,0,crosspiece_height/2]) difference () {
		box(crosspiece_width,len,crosspiece_height);
		// Assorted slotments
		translate ([0,len*0.33,0]) box(m4_clearance_rad_v*2,len*0.17,crosspiece_height*2);
		translate ([0,len*0.14,0]) box(m4_clearance_rad_v*2,len*0.14,crosspiece_height*2);
		translate ([0,len*-0.33,0]) box(m4_clearance_rad_v*2,len*0.17,crosspiece_height*2);
		translate ([0,len*-0.14,0]) box(m4_clearance_rad_v*2,len*0.14,crosspiece_height*2);
		m8_hole_vert(crosspiece_height*2);
	}
}

module y_bar_hole_cluster() {
	translate ([y_bar_hole_spacing/2,-y_bar_hole_spacing/2,0]) m4_hole_vert(holder_height*4);
	translate ([y_bar_hole_spacing/2,-y_bar_hole_spacing/-2,0]) m4_hole_vert(holder_height*4);
	translate ([y_bar_hole_spacing/-2,-y_bar_hole_spacing/2,0]) m4_hole_vert(holder_height*4);
	translate ([y_bar_hole_spacing/-2,-y_bar_hole_spacing/-2,0]) m4_hole_vert(holder_height*4);
	m8_hole_vert(holder_height*4);
}


module side_hole_set() {
	translate([holder_length/2,y_bar_hole_spacing,holder_height/2]) rotate ([0,-90,0]) m4_hole_horiz(20);
	translate([holder_length/2-frame_width+3,-y_bar_hole_spacing,holder_height/2]) rotate ([180,-90,0]) m4_hole_horiz_with_hex(20);
	translate([holder_length/2,y_bar_hole_spacing*3,holder_height/2]) rotate ([0,-90,0]) m4_hole_horiz(20);
	translate([holder_length/2-frame_width+3,-y_bar_hole_spacing*3,holder_height/2]) rotate ([180,-90,0]) m4_hole_horiz_with_hex(20);
	translate([holder_length/2-frame_width+3,-y_bar_hole_spacing*3,holder_height/2]) rotate ([180,-90,0]) m4_hole_horiz(70);
	translate([holder_length/2-frame_width+3,y_bar_hole_spacing*3,holder_height/2]) rotate ([180,-90,0]) m4_hole_horiz(70);
}

module corner_lugs() {
	translate([holder_length/2-frame_width-4,holder_length/2-y_bar_cube_width-3,holder_foot_height/2])
		difference () {
			cylinder(h=holder_foot_height,r=m4_clearance_rad_v*2,center=true);
			m4_hole_vert(holder_foot_height*2);
		}
}

module holder() {
	difference ()	 {
		union () {
			// Basic frame
			translate ([0,0,holder_height/2]) difference () {
				box(holder_length,holder_width,holder_height);
				box(holder_length-2*frame_width,holder_width-2*frame_width,holder_height*2);
			}
			difference () {union () {
				// Corner braces
				translate([(holder_length-y_bar_cube_width)/2,(holder_width-y_bar_cube_width)/2,holder_foot_height/2])
					box(y_bar_cube_width,y_bar_cube_width,holder_foot_height);
				translate([(holder_length-y_bar_cube_width)/-2,(holder_width-y_bar_cube_width)/2,holder_foot_height/2])
					box(y_bar_cube_width,y_bar_cube_width,holder_foot_height);
				translate([(holder_length-y_bar_cube_width)/2,(holder_width-y_bar_cube_width)/-2,holder_foot_height/2])
					box(y_bar_cube_width,y_bar_cube_width,holder_foot_height);
				translate([(holder_length-y_bar_cube_width)/-2,(holder_width-y_bar_cube_width)/-2,holder_foot_height/2])
					box(y_bar_cube_width,y_bar_cube_width,holder_foot_height);
				}
				// Clip inside corners off neatly.
				rotate ([0,0,45]) scale ([0.78,0.78,2]) box(holder_length,holder_width,holder_height*1.2);
			}
			// Crosspieces
			crosspiece(holder_length);
			rotate ([0,0,90]) crosspiece(holder_width);
			rotate ([0,0,45]) crosspiece(holder_width);
			rotate ([0,0,-45]) crosspiece(holder_width);
			// Corner lugs
			rotate ([0,0,90]) corner_lugs();
			rotate ([0,0,-90]) corner_lugs();
			rotate ([0,0,180]) corner_lugs();
			corner_lugs();
		}
		// Holes to be hacked out. Start with bar gripping holes
		translate([(holder_length-y_bar_cube_width)/2,(holder_width-y_bar_cube_width)/2,0])
			y_bar_hole_cluster();
		translate([(holder_length-y_bar_cube_width)/-2,(holder_width-y_bar_cube_width)/2,0])
			y_bar_hole_cluster();
		translate([(holder_length-y_bar_cube_width)/2,(holder_width-y_bar_cube_width)/-2,0])
			y_bar_hole_cluster();
		translate([(holder_length-y_bar_cube_width)/-2,(holder_width-y_bar_cube_width)/-2,0])
			y_bar_hole_cluster();
		// Now side bolt holes
		side_hole_set();
		rotate ([0,0,90]) side_hole_set();
		rotate ([0,0,180]) side_hole_set();
		rotate ([0,0,-90]) side_hole_set();
		// Space in case anyone wants to put a NEMA17 in it.
		translate ([0,0,10+crosspiece_height-1]) cylinder(h=20,r=12,center=true);
	}
}

holder();
