
/*
 *  Remake of x-end-bracket_2off
 *  by Len Trigg <lenbok@gmail.com> 2010-05-08
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

<mendel.inc>
<mendel.conf>

// Maybe move these two puppies into mendel.inc
module m3_hole_vert(l) {
	cylinder(l,m3_clearance_rad,m3_clearance_rad,center=true);
}
module m3_slot_vert(l) {
        box(m3_clearance_rad*2, 6, l);
}


// Outer dimensions
x_end_bracket_length=76;
x_end_bracket_width=62;
x_end_bracket_depth=10;

// Size of the square where the motor attaches
x_end_bracket_inner_length=44;
x_end_bracket_inner_width=43;

// Thickness of the raised wall
x_end_bracket_inner_wall=5; 
x_end_bracket_slot_width=12; 

// bolt insets
x_end_bracket_bolt_inset=4;

module x_end_bracket_2off() {
    yoff1=(x_end_bracket_inner_width-x_end_bracket_width)/2;
    yoff2=3*x_end_bracket_inner_width/2-x_end_bracket_width/2+x_end_bracket_inner_wall;
    xoff1=-x_end_bracket_inner_length-x_end_bracket_inner_wall;
    xoff2=x_end_bracket_inner_length+x_end_bracket_inner_wall;
    yoff3=4;
    yoff4=-x_end_bracket_width/2+3*x_end_bracket_bolt_inset/2;
    yoff5=x_end_bracket_width/2-9;
    xoff3=x_end_bracket_length/2-x_end_bracket_bolt_inset;
    xoff4=xoff3-21.5;
    difference() {
        box(x_end_bracket_length, x_end_bracket_width, x_end_bracket_depth);
        union() {
            // Cut out some squares to leave the raised crosses
            translate([0,yoff1-1,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width+2, x_end_bracket_depth);
            translate([xoff1,yoff1-1,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width+2, x_end_bracket_depth);
            translate([xoff2,yoff1-1,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width+2, x_end_bracket_depth);
            translate([xoff1,yoff2,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width, x_end_bracket_depth);
            translate([0,yoff2,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width, x_end_bracket_depth);
            translate([xoff2,yoff2,x_end_bracket_depth/2]) box(x_end_bracket_inner_length, x_end_bracket_inner_width, x_end_bracket_depth);
            
            // Motor mounting bits
	    translate([0,-nema17_side/2+12,7]) nema_17();
	    translate([0,-x_end_bracket_width/2,0]) box(x_end_bracket_slot_width, x_end_bracket_inner_width, x_end_bracket_depth+2);
	    translate([0,-x_end_bracket_width/2,0]) rotate([0,0,45]) box(x_end_bracket_slot_width+2, x_end_bracket_slot_width+2, x_end_bracket_depth+2);

            // screw slots
	    translate([-xoff3,yoff3,0]) m3_slot_vert(x_end_bracket_depth+2);
	    translate([xoff3,yoff3,0]) m3_slot_vert(x_end_bracket_depth+2);
	    translate([-xoff3,yoff4,0]) m3_slot_vert(x_end_bracket_depth+2);
	    translate([xoff3,yoff4,0]) m3_slot_vert(x_end_bracket_depth+2);
            // screw holes
	    translate([-xoff3,yoff5,0]) m4_hole_vert(x_end_bracket_depth+2);
	    translate([xoff3,yoff5,0]) m4_hole_vert(x_end_bracket_depth+2);
	    translate([-xoff4,yoff5,0]) m4_hole_vert(x_end_bracket_depth+2);
	    translate([xoff4,yoff5,0]) m4_hole_vert(x_end_bracket_depth+2);
        }
    }
}

// In case you want to see the original for comparison purposes
//translate([-x_end_bracket_length/2, -x_end_bracket_width/2, -x_end_bracket_depth]) import_stl("x-end-bracket_2off.stl");

translate([0, 0, x_end_bracket_depth/2]) x_end_bracket_2off();
