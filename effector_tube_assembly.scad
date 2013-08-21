include <effector_tube.scad>
include <effector_flange.scad>
include <effector_cup.scad>;
use <jhead.scad>;
include <config.scad>;

module effector_tube_assembly() {
	color(color) effector_cup();
	rotate([180, 0, 0]) hotend_jhead();
	translate([0, 0, 4.2]) color(color) effector_flange();
	translate([0, 0, 4.5]) color([0.2, 0.2, 0.2]) effector_tube();
}

//effector_tube_assembly();