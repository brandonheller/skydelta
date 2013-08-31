// Effector Tensioner
// Provides an easy way to get the string lengths on top and bottom equal.

include <config.scad>;
include <effector_base.scad>;

body_r = 4.25;
body_h = 5;

filament_r = 0.5/2;
filament_boss_r = 1.5;
filament_boss_offset = effector_body_r - mount_radius; // XY distance from filament center to screw center

m3_nut_h = 1.75;

$fn = 32;

module effector_tensioner() {
	difference() {
		hull() {
			// Main screw body
			cylinder(r=body_r, h=body_h);
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

effector_tensioner();