// Effector Standoff
// Ensures correct spacing between two halves of the effector.
// This size, 52mm, has Al and nylon replacements available, from Digi-Key and McMaster-Carr.

include <config.scad>;

standoff_r = (7.0)/2;
standoff_h = 52;
standoff_thread_h = 10;

module effector_standoff() {
	difference() {
		// Body
		cylinder(r=standoff_r, h=standoff_h, $fn=6);
		// Screw holes
		translate([0, 0, -delta]) cylinder(r=m3_thread_r, h=standoff_thread_h+delta, $fn=32);
		translate([0, 0, standoff_h+delta]) rotate([180, 0, 0]) cylinder(r=m3_thread_r, h=standoff_thread_h+delta, $fn=32);
	}
}

//rotate([90, 0, 0]) effector_standoff();