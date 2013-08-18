// Idler mount; rotates to follow the line as the effector moves.

include <bearing_608.scad>;
include <idler.scad>;
include <idler_mount.scad>;

inside_h=idler_or*2+idler_clearance;

idler_mount_assembly(inside_h, [inside_h/2]);