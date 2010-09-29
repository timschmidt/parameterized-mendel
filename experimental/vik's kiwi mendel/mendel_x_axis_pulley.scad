// Mendel ball chain pulley for the Y axis. Designed for 3.2-3.5mm chain. Takes a piece of 3/16" brass tube in the centre as a bushing.
//
//  GPL V3 Licenced, by Vik Olliver 2010-03-16

pulley_min_rad=5;
pulley_max_rad=8;
pulley_height=7;
pulley_bushing_rad=2.9;

translate ([0,0,pulley_height/2]) difference () {
	union () {
		translate ([0,0,pulley_height/4])
			cylinder(pulley_height/2,r1=pulley_min_rad,r2=pulley_max_rad,center=true);
		translate ([0,0,-pulley_height/4])
			cylinder(pulley_height/2,r2=pulley_min_rad,r1=pulley_max_rad,center=true);
	}
	cylinder(h=pulley_height*2,r=pulley_bushing_rad, center=true);
}