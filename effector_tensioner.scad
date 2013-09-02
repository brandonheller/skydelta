// Effector Tensioner
// Provides an easy way to get the string lengths on top and bottom equal.

include <config.scad>;
include <effector_base.scad>;

body_r = 5;
body_h = 5;

filament_r = 1.0/2;
filament_boss_r = 2.0;
filament_boss_offset = filament_exit_offset - mount_radius; // XY distance from filament center to screw center

m3_nut_h = 2.5;

$fn = 32;

module effector_tensioner() {
	difference() {
		hull() {
			// Main screw body
			cylinder(r=body_r, h=body_h, $fn=6);
			// Filament holder
			translate([filament_boss_offset, 0, 0]) cylinder(r=filament_boss_r, h=body_h);
		}
		// Screw hole
		translate([0, 0, -delta]) cylinder(r=m3_r, h=body_h+2*delta);
		// Filament hole
		translate([filament_boss_offset, 0, -delta]) cylinder(r=filament_r, h=body_h+2*delta);
		// Nut trap
		translate([0, 0, body_h-m3_nut_h]) cylinder(r=m3_nut_r, h=m3_nut_h+delta, $fn=6);
	}
}

//effector_tensioner();