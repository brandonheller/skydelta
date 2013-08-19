// Idler mount; rotates to follow the line as the effector moves.

include <bearing_608.scad>;
include <idler.scad>;
include <idler_mount.scad>;

inside_h=idler_or*2+idler_clearance;

module idler_mount_assembly_single() {
	idler_mount_assembly(inside_h, [inside_h/2]);
}

//idler_mount_assembly_single();