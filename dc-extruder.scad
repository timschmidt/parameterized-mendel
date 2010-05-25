// Parametric Mendel DC Motor Extruder Mk2 in SCAD by Vik,
// vik@diamondage.co.nz, 2010-05-21

<mendel.conf>
<mendel.inc>

bearing_clearance_rad=8;
filament_rad=1.6;		// Includes some clearance.
ptfe_rad=9.2;			// 18mm dia PTFE spacer (9.2). May well be 16mm rad for you (8.2)
extruder_thick=31;
filament_x_offset=26.497;
filament_inset=10;
extruder_axle_line=extruder_height*0.45;
extruder_width=62;
gear_separation=38;
pinch_axle_height=18;

filament_oversize=0.5;	// If your extruder is perfect this can be zero :)
module filament_cavity() {
	union () {
		cylinder(100,filament_rad+filament_oversize,filament_rad+filament_oversize,center=true);
		translate ([0.7*filament_rad,0,0]) rotate ([0,0,45]) {
			cube([filament_rad+filament_oversize,filament_rad+filament_oversize,100],center=true);
		}
	}
}

motor_bracket_len=42;
motor_bracket_wid=17;
motor_bracket_height=43;

module extruder_dc_body() {
	difference () {
		union () {
			// Main block of the thing.
	       		translate([extruder_width/2-2,extruder_thick/2,22])cube([extruder_width,extruder_thick,extruder_height], center = true);
			// PTFE holder (for woodscrews instead of epoxy)
			translate([filament_x_offset,extruder_thick/2,0])cube([22,extruder_thick,20], center = true);
			// Chunk out the back to bolt the motor to
			translate([motor_bracket_wid/2+18,extruder_thick+motor_bracket_len/2,motor_bracket_height/2+7])
				difference () {
					box(motor_bracket_wid,motor_bracket_len,motor_bracket_height-12);
					translate([0,0,-motor_bracket_height/2]) rotate ([20,0,0]) box(motor_bracket_wid+1,motor_bracket_len*2,motor_bracket_height-12);
				}
		}
	union()
		{
		// Shoulders.
		translate([53,extruder_thick,40])cube([17,extruder_thick*2.1,21],center=true);
		translate([2.8,35,40])cube([13.399,80,21],center = true);
		//Yer filament.
		translate([filament_x_offset,filament_inset,21.635])rotate([0,0,90]) {
			 filament_cavity();
			cylinder(h=6,r1=filament_rad+filament_oversize,r2=(filament_rad+filament_oversize)*1.7,center=true);
		}
		// Nice & roomy place for the axle covered in nuts to go
		translate ([filament_x_offset,filament_inset+2*filament_rad,pinch_axle_height]) {
			rotate ([90,0,90]) {
				scale(1.8) m8_hole_horiz(60);
				translate([-bearing_608_rad_h,0,0]) cube([bearing_608_rad_h*2,bearing_608_rad_h*2,bearing_608_len*3],center=true);
				translate([0,0,bearing_608_len]) hole_horiz(rad=bearing_608_rad_h,l=bearing_608_len+0.6);
				translate([0,0,-bearing_608_len]) hole_horiz(rad=bearing_608_rad_h,l=bearing_608_len+0.6);
			}
			// Slot to drop axle in through.
			translate([0,-10,0]) box(extruder_width+10,18,14);
			
		}
		// M4 mounting holes
		translate([4,extruder_thick-5,22.0])rotate([0,0,90]) m4_hole_horiz(extruder_height*1.1);
		translate([4+extruder_mount_hole_spacing,extruder_thick-5.09,22])rotate([0,0,90])
			m4_hole_horiz(extruder_height*1.1);
		// PTFE holder
		translate([filament_x_offset,filament_inset,0]) rotate ([90,0,0]) rotate([90,90,0]) hole_horiz(ptfe_rad,23);
		// 3mm holes for woodscrews
		#translate([filament_x_offset-6.5,extruder_thick/2,-2.8]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);
		#translate([filament_x_offset+6.5,extruder_thick/2,-2.8]) rotate ([90,0,0]) cylinder(h=extruder_thick*2,r=2.5,center=true);


		// Slot for motor screws
		translate([extruder_width/2,filament_inset+gear_separation+4,pinch_axle_height+21])
			box(extruder_width,28,m3_clearance_rad*2);
		}
		// Idler retaining holes
		translate([filament_x_offset,filament_inset+extruder_thick-15,pinch_axle_height]) {
			// Optional hole for nut access
			//translate ([0,8,ei_trans_spacing/2]) rotate ([90,0,90]) hole_horiz(4,300);
			translate ([ei_cis_spacing/2,0,ei_trans_spacing/2]) rotate ([90,30,0]) m4_hole_vert_with_hex(100);
			translate ([-ei_cis_spacing/2,0,ei_trans_spacing/2]) rotate ([90,30,0]) m4_hole_vert_with_hex(100);
			translate ([ei_cis_spacing/2,0,-ei_trans_spacing/2]) rotate ([90,30,0]) m4_hole_vert_with_hex(100);
			translate ([-ei_cis_spacing/2,0,-ei_trans_spacing/2]) rotate ([90,30,0]) m4_hole_vert_with_hex(100);
		}
	}
}

rotate ([90,0,0]) 
	extruder_dc_body();



