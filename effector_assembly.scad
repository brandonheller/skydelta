include <config.scad>;
include <effector_lower.scad>;
include <effector_upper.scad>;
include <effector_standoff.scad>;
include <effector_tensioner.scad>;
use <jhead.scad>;

module effector_assembly() {
	rotate([0, 0, 0]) rotate([180, 0, 0]) color(color) effector_lower();
	translate([0, 0, standoff_h+height]) rotate([0, 0, 60]) color(color) effector_upper();
	rotate([180, 0, 0]) hotend_jhead();
	for (a = [0:120:359]) rotate([0, 0, 60+a]) {
		// Standoff mounts
		for (b = [-1]) rotate([0, 0, b * standoff_offset_deg]) {
			translate([0, standoff_offset, height/2]) color(black) effector_standoff();
		}
		// Tensioners
		translate([0, mount_radius, height/2+35]) color(red) rotate([0, 0, -90]) rotate([0, 180, 0]) effector_tensioner();
	}
}

//effector_assembly();