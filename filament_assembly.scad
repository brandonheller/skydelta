include <bearing_holder.scad>;
include <idler_mount.scad>;

module idler_assembly() {
	translate([length/2, 0, bearing_base_thickness+flange_height]) {
		bearing_holder();
		translate([0, 0, bearing_608_h]) idler_mount_assembly_double();
		translate([0, 0, 92.5]) rotate([180, 0, 0]) bearing_holder();
	}
}

//idler_assembly();
