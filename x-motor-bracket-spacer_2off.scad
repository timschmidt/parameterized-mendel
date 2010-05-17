
/*
 *  Remake of x-motor-bracket-spacer_2off
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

spacer_length=23; // Slightly longer than the original
spacer_wall_thickness=2;

module x_motor_bracket_spacer_2off() {
    difference() {
	cylinder(spacer_length, m8_tight_rad+2, m8_tight_rad+2,center=true);
	cylinder(spacer_length+2,m8_tight_rad,m8_tight_rad,center=true);
    }
}

translate([0, 0, spacer_length/2]) x_motor_bracket_spacer_2off();
