// Bug found when making foot for Mendel Y platform


post_wid=20;

module spring() {
	// Rough hack.
	union () {
		translate ([0,0,post_wid/2]) cube(post_wid, center=true);
		translate ([15,0,10]) {
			cube([post_wid*2,post_wid*1.1,post_wid*0.1], center=true);
		}
	}
}

translate ([post_wid*1.4,0,post_wid*0.35]) spring();
