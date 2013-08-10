// Master assembly file.
use <filament_assembly.scad>;

extrusion_width = 15;
extrusion_height = 500;
post_r = 140; // distance from center of print circle to center of post
starting_height = 225;
separation = 150;

module post() {
	translate([extrusion_width/2, 0, extrusion_height/2]) cube([extrusion_width, extrusion_width, extrusion_height], center=true);
	for (i = [starting_height, starting_height+separation]) {
		translate([0, 0, i]) rotate([0, 0, 180]) idler_assembly();
	}
}

for (i = [0: 120: 359]) {
	 rotate([0, 0, i]) translate([post_r, 0, 0]) post();
}