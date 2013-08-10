include <bearing_608.scad>;
include <bearing_holder.scad>;
include <idler_mount.scad>;

module idler_assembly() {
	translate([length/2, 0, base_thickness+flange_height]) {
		bearing_holder();
		translate([0, 0, bearing_608_h]) idler_mount_assembly();
		translate([0, 0, 38]) rotate([180, 0, 0]) bearing_holder();
	}
}

idler_assembly();
