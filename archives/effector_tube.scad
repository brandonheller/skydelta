// Simple tube.
include <config.scad>;

// Sample carbon tube:
// Goodwinds 020976 (http://goodwinds.com/20976.html)
// 9.52 mm OD
// 7.37 mm ID
effector_tube_or = 9.52/2;
effector_tube_ir = 7.37/2;
effector_tube_h = 90.0;

module effector_tube() {
	difference() {
		cylinder(r=effector_tube_or, h=effector_tube_h, $fn=64);
		cylinder(r=effector_tube_ir, h=big, center=true, $fn=32);
	}
}

//effector_tube();