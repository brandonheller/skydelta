// Master assembly file.
use <filament_assembly.scad>;
include <effector_tube_assembly.scad>;

extrusion_width = 15;
extrusion_height = 400;
post_r = 140; // distance from center of print circle to center of post
starting_height = 235;
separation = 60;

black = [0.3, 0.3, 0.3];

module post_assembly() {
	// Post
	translate([extrusion_width/2, 0, extrusion_height/2]) color(black)
		cube([extrusion_width, extrusion_width, extrusion_height], center=true);
	for (i = [starting_height]) {
		translate([0, 0, i]) rotate([0, 0, 180]) idler_assembly();
	}
}

module spike() {
	for (i = [0: 120: 359]) {
		rotate([0, 0, i]) translate([post_r, 0, 0]) post_assembly();
	}

	translate([0, 0, 80]) effector_tube_assembly();
}

spike();