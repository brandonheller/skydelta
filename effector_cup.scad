// Effector Cup
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

hotend_radius = 8.06;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;

standoff_r = 4;
standoff_offset = effector_body_r + standoff_r;  // XY offset from center
standoff_offset_deg = 20;  // rotation offset relative to line between center and screw hole

module effector_cup() {
	difference() {
		union() {
			// Main body
			cylinder(r=effector_body_r, h=height, center=true, $fn=64);
			// Extensions for standoff mounts
			for (a = [0:120:359]) rotate([0, 0, a]) {
				for (b = [-1, 1]) rotate([0, 0, b * standoff_offset_deg]) {
					hull() {
	 					translate([0, standoff_offset, 0]) cylinder(r=standoff_r, h=height, center=true, $fn=24);
	 					translate([0, standoff_offset-10, 0]) cylinder(r=standoff_r, h=height, center=true, $fn=24);
					}
				}
	  		}
		}
		// Cutout for hotend
		translate([0, 0, push_fit_height-height/2]) cylinder(r=hotend_radius, h=height, $fn=64);
		// Screw cutout
		translate([0, 0, -6]) import("m5_internal.stl");
		// Thread-forming mounting holes (for adding screws to secure clip below)
		for (a = [0:60:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0]) cylinder(r=m3_thread_r, h=2*height, center=true, $fn=24);
	  	}
		// Holes in standoff mounts
		for (a = [0:120:359]) rotate([0, 0, a]) {
			for (b = [-1, 1]) rotate([0, 0, b * standoff_offset_deg]) {
				translate([0, standoff_offset, 0]) cylinder(r=m3_r, h=height+2*delta, center=true, $fn=24);
			}
		}
	}
}

effector_cup();