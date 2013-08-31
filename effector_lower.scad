// Effector Lower
// Mounts to hotend, hotend mounting clip, standoffs, and possibly auto-leveling probe.

include <config.scad>;
include <effector_base.scad>;

module effector_lower() {
	difference() {
		effector_base();
		// Cutout for hotend
		translate([0, 0, push_fit_height-height/2]) cylinder(r=hotend_radius, h=height, $fn=64);
		// Screw cutout
		translate([0, 0, -6]) import("m5_internal.stl");
		// Thread-forming mounting holes (for adding screws to secure clip below)
		for (a = [0:60:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0]) cylinder(r=m3_thread_r, h=2*height, center=true, $fn=32);
	  	}
	}
}

//effector_lower();