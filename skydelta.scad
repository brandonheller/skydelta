// Master assembly file.
include <filament_assembly.scad>;
include <effector_assembly.scad>;
include <nema17_mount.scad>;
include <utl.NEMA.scad>;
include <spool.scad>;

extrusion_width = 15;
extrusion_height = 600;
post_r = 240; // distance from center of print circle to center of post
starting_height = 420;
separation = 60;

module post_assembly() {
	// Post
	translate([extrusion_width/2, 0, extrusion_height/2]) color(black) cube([extrusion_width, extrusion_width, extrusion_height], center=true);
	for (i = [starting_height]) {
		translate([0, 0, i]) rotate([0, 0, 180]) idler_assembly();
	}
	translate([-spacing, extrusion_width/2+3.5, nema17_width/2+extrusion_width]) rotate([0, 0, 180]) color(color) nema17_mount();
	translate([-nema17_width/2-spacing, extrusion_width/2+3.5, nema17_width/2+extrusion_width]) {
		rotate([90, 0, 0]) nema17(1, 0);
		rotate([90, 0, 0]) translate([0, 0, 3]) spool();
	}
}

module spike() {
	for (i = [0: 120: 359]) {
		rotate([0, 0, i]) translate([post_r, 0, 0]) post_assembly();
	}
	translate([0, 0, 120]) effector_assembly();
}

//post_assembly();
spike();