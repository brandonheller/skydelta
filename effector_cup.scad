// Effector Cup
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

hotend_radius = 8.06;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;

module effector_cup() {
	difference() {
		// Main body
		cylinder(r=effector_body_r, h=height, center=true, $fn=64);
		// Cutout for hotend
		translate([0, 0, push_fit_height-height/2]) cylinder(r=hotend_radius, h=height, $fn=64);
		// Screw cutout
		translate([0, 0, -6]) import("m5_internal.stl");
		// Clearance mounting holes (for screwing into tubes above)
		//for (a = [0:120:359]) rotate([0, 0, a]) {
//	 		translate([0, mount_radius, 0]) cylinder(r=m3_r, h=2*height, center=true, $fn=24);
//			translate([0, mount_radius, height/4]) cylinder(r=m3_cap_r, h=m3_cap_h+delta, $fn=24);
	  	//}
		// Thread-forming mounting holes (for adding screws to secure clip below)
		for (a = [0:60:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0]) cylinder(r=m3_thread_r, h=2*height, center=true, $fn=24);
	  	}
	}
}

effector_cup();