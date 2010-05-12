<mendel_misc.inc>

module driven_gear() {
	difference () {
		// Scale gear to suit 4mm chain
		scale (0.8) {
			 translate ([-27,-25,0]) import_stl("beaded_belt_gear_95.stl", convexity = 5);
		}
		// Chop an M8 rod & nut cavity out of the middle
		translate ([0,0,1.9]) rotate ([180,0,0]) m8_hole_vert_with_hex(20);
	}
}

module drive_gear() {
	difference () {
		union () {
			// Scale gear to suit 4mm chain
			scale (0.8) {
				 translate ([-27,-25,0]) import_stl("beaded_belt_gear_95.stl", convexity = 5);
			}
			// Collar for drive shaft
			translate ([0,0,7.5]) cylinder(h=15,r=7,center=true);
		}
		// Chop a NEMA17 shaft out of the middle
		difference () {
			cylinder(h=40,r=3,center=true);
			translate ([7,0,0]) box(10,10,50);
		}
	}
}

drive_gear();