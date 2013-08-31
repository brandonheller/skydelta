// Effector Standoff
// Ensures correct spacing between two halves of the effector.
// This size, 52mm, has Al and nylon replacements available, from Digi-Key and McMaster-Carr.

include <config.scad>;

standoff_r = 6;
standoff_h = 52;

module effector_standoff() {
	difference() {
		// Body
		cylinder(r=standoff_r, h=standoff_h, $fn=6);
		// Screw hole
		translate([0, 0, -delta]) cylinder(r=m3_r, h=standoff_h+2*delta, $fn=32);
	}
}

//effector_standoff();