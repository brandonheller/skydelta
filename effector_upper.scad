// Effector Upper
// Mounts to rubber bands and standoffs.

include <config.scad>;
include <effector_base.scad>;

center_hole_r = mount_radius - m3_r - 3;

module effector_upper() {
	difference() {
		effector_base();
		// Cutout for bowden tube
		translate([0, 0, 0]) cylinder(r=hotend_radius, h=height+2*delta, center=true, $fn=64);
		// Through-holes for tensioner screw mounting.
		for (a = [0:60:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0]) cylinder(r=m3_r, h=2*height, center=true, $fn=32);
	  	}
	}
}

//effector_upper();