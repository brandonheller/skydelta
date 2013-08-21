// This part mounts a NEMA17 motor to 15x15 extrusion (e.g. OpenBeam)
include <bearing_608.scad>;

// Dimensions from:
// https://ultimachine.com/sites/default/files/Nema17StepperMotor.pdf
nema17_hole_spacing = 31; // Grid of 4
nema17_width = 42.0; //  Measured, not max.
nema17_hole_r = 3.0/2;
nema17_edge = (nema17_width-nema17_hole_spacing)/2;
nema17_flange_r = (22+0.2)/2;

thickness = 3.5;
extrusion_width = 15;
spool_r = 9; // Grabercars Kossel spools are 18mm measured at the center of the filament.
filament_offset = bearing_608_or;
// Extra spacing between extrusion & holes; must ensure screw head (~3mm) passes
// Also should align the edge of the spool with the point at which it comes out of the bearing.
//spacing = 1.00; 
spacing = (filament_offset + spool_r) - nema17_width/2;
covered_width = 15;  // Width of the stepper covered by this part

tensioner_r = 8.5/2;
tensioner_x_offset = 14;
tensioner_len = 10;

m3_nut_r= (6.2+0.10)/2;
m3_screw_head_r = 6.5/2;

$fn = 64;

big = 100;
delta = -0.1;

module nema17_mount() {
	difference() {
		union() {
			// Main body
			translate([-extrusion_width-spacing, 0, -nema17_width/2]) cube([nema17_width+extrusion_width+spacing, thickness, nema17_width]);
			// Tensioner appendix
			difference() {
				// Solid portion
				hull() {
					translate([-tensioner_x_offset, -tensioner_r, -nema17_width/2]) {
						cylinder(r=tensioner_r, h=tensioner_len);
					}
					translate([-tensioner_x_offset, -1, -nema17_width/2]) {
						cylinder(r=tensioner_r, h=tensioner_len);
					}
				}
				// Holes for tensioning nut/screw
				translate([-tensioner_x_offset, -tensioner_r, -nema17_width/2]) {
					translate([0, 0, 0]) cylinder(r=nema17_hole_r, h=big, center=true);
					translate([0, 0, 2]) rotate([180, 0, 0]) cylinder(r=m3_nut_r, h=big, $fn=6);
				}
				// Cutout to give screw head some clearance
				translate([-spacing-extrusion_width/2, -delta, -nema17_hole_spacing/2]) rotate([90, 0, 0]) cylinder(r=m3_screw_head_r, h=big);
			}
		}
		for (i = [-1, 1]) {
			for (j = [-spacing-extrusion_width/2, nema17_edge, nema17_width-nema17_edge]) {
				translate([j, -big/2, i*nema17_hole_spacing/2]) rotate([-90, 0, 0]) cylinder(r=nema17_hole_r, h=big);
			}
		}
		// Hole for center flange
		translate([nema17_width/2, -big/2, 0]) rotate([-90, 0, 0]) cylinder(r=nema17_flange_r, h=big);
		// Trim unneeded bits off the side
		translate([covered_width, -big/2, -big/2]) cube([big, big, big]);
	}
}

//nema17_mount();
