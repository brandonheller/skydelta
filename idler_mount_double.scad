// Idler mount; rotates to follow the line as the effector moves.

include <bearing_608.scad>;
include <idler.scad>;
include <idler_mount.scad>;

idler_spacing=50	;  // Gap between the two idlers.
inside_h=idler_or*2+idler_clearance+idler_spacing;
idler_offset=idler_or+idler_clearance/2;

//idler_mount_assembly(inside_h, [idler_offset, idler_offset+idler_spacing]);