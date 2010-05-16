// y-bar-clamp_10off remake in OpenSCAD
// by Josef Prusa 
// http://prusadjs.cz
// Modded by vik@diamondage.co.nz
// GNU GPLV3

<mendel.inc>
<mendel.conf>

// Tip for printing version with nut traps. Print layers with nut traps, then insert real nuts and continue printing with them.

nutTraps = 0; // 0 or 1 and it also makes the object higher for same strength
shelfLength=0; // Length of a shelf to put microswitches or optos on. Generally zero or 19
shelf_vertical=0;	// If 1, shelf aranged in a "L" for vertical switches.

cubeHeight=13.37+(nutTraps*4);

holeRad=m4_clearance_rad_v;	// Radius for the "M4" hole.
barRad=4.1;		// Radius of the bar being clamped. 5.1 or 4.1 generally

// A PCB spacer. Also used to hold this assembly on the Z axis slide bar, and
// may be inserted between the Y bar clamps to increase build height.
// make it too big and the M4x40 bolts won't reach. Only useful for mounting the circuit board holder
spacerHeight=0;//5.5;
module pcb_spacer () {
	difference() {
		cube(size=[y_bar_cube_width,y_bar_cube_width,spacerHeight],center=true);
		translate(v=[y_bar_hole_spacing/2,y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
		translate(v=[-y_bar_hole_spacing/2,y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
		translate(v=[y_bar_hole_spacing/2,-y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
		translate(v=[-y_bar_hole_spacing/2,-y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
	}
}

module y_bar_clamp() {
		difference(){
			union () {
				// Sticky outy shelf - rotate z by 90 for lateral.
				rotate ([0,0,0]) {
					translate ([(cubeHeight+shelfLength)/2,(y_bar_cube_width-8)/2,0])
						cube(size=[shelfLength,8,cubeHeight],center=true);
					if (shelf_vertical==1) {
						// Free limb of "L"
						translate ([(y_bar_cube_width+shelfLength)/2+1,0,0])
							cube(size=[7,y_bar_cube_width,cubeHeight],center=true);
					} else {
						translate ([(cubeHeight+shelfLength)/2,(y_bar_cube_width-8)/-2,0])
							cube(size=[shelfLength,8,cubeHeight],center=true);
					}
				}
				cube(size=[y_bar_cube_width,y_bar_cube_width,cubeHeight],center=true);
			}
			// Cavity for Y rod
			translate(v=[0,0,6.9-barRad+(nutTraps*2)])rotate(a=[90,0,0])
				cylinder(r=barRad, h=60, center=true);
			translate(v=[0,0,11.5-barRad+(nutTraps*2)])
				cube(size=[barRad*2,60,10],center=true);
			translate(v=[0,6,9+(nutTraps*2)])cube(size=[12,4,y_bar_cube_width-4],center=true);
			translate(v=[0,-6,9+(nutTraps*2)])cube(size=[12,4,y_bar_cube_width-4],center=true);
			
			if (nutTraps==1) {
				translate(v=[y_bar_hole_spacing/2,-y_bar_hole_spacing/2,-6]) m4_hole_vert_with_hex(y_bar_cube_width+10);
				translate(v=[y_bar_hole_spacing/2,y_bar_hole_spacing/2,-6]) m4_hole_vert_with_hex(y_bar_cube_width+10);
				translate(v=[-y_bar_hole_spacing/2,y_bar_hole_spacing/2,-6]) m4_hole_vert_with_hex(y_bar_cube_width+10);
				translate(v=[-y_bar_hole_spacing/2,-y_bar_hole_spacing/2,-6]) m4_hole_vert_with_hex(y_bar_cube_width+10);
			} else {
				translate(v=[y_bar_hole_spacing/2,y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
				translate(v=[-y_bar_hole_spacing/2,y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
				translate(v=[y_bar_hole_spacing/2,-y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
				translate(v=[-y_bar_hole_spacing/2,-y_bar_hole_spacing/2,0]) m4_hole_vert(y_bar_cube_width+10);
			}
		}
		
}



// Position things nicely.

translate ([0,0,cubeHeight/2]) y_bar_clamp();
translate ([y_bar_cube_width+shelfLength+5,0,spacerHeight/2]) pcb_spacer();
