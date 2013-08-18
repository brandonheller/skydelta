// Idler mount; rotates to follow the line as the effector moves.

include <bearing_608.scad>;
include <idler.scad>;
include <idler_mount.scad>;

inside_h=idler_or*2+idler_clearance;

module idler_mount_assembly() {
	translate([0, 0, -bearing_608_h]) bearing_608();
	translate([0, 0, taper_h+outer_cyl_h+taper_h]) bearing_608();
	translate([idler_filament_r, 0, taper_h+outer_cyl_h/2]) rotate([90, 0, 0]) color(idler_color) idler();
	idler_mount(inside_h, [inside_h/2]);
}

//idler_mount_assembly();