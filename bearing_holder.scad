include <bearing_608.scad>;

screw_r = 3.0/2;
bearing_base_thickness = 3.5;
height = bearing_608_h+bearing_base_thickness; // height in direction of bearing axis
bearing_width_clearance = 3.0;
width = bearing_608_or*2+bearing_width_clearance; 
length = bearing_608_or*2; // distance sticking out from OpenBeam
cutout_width = 14;
bearing_gap = 0.75; // space to clear bearing motion
extrusion_width = 15;
main_thickness = 3.0;
flange_height = 20;
flange_out = 20;

big = 100;

delta = 1;

$fn = 64;

module bearing_holder() {
	difference() {
		union() {
			// Body
			translate([0, 0, bearing_608_h/2-bearing_base_thickness/2]) cube([length, width, bearing_608_h + bearing_base_thickness], center=true);
			// Flange
			translate([-length/2, -extrusion_width/2, -flange_height-bearing_base_thickness]) cube([main_thickness, extrusion_width, flange_height]);
			// Side flange supports
			for (i = [-1, 1]) {
				translate([-length/2+flange_out/2, i*(extrusion_width/2-main_thickness/2), -bearing_base_thickness-flange_height/2]) 
cube([flange_out, main_thickness, flange_height], center=true);
			} 
		}
		// Primary bearing cutout
		cylinder(r=bearing_608_or, h=bearing_608_h + delta);
		// Cutout to avoid overly narrow paths
		translate([0, 0, bearing_608_h/2+delta/2]) cube([big, cutout_width, bearing_608_h + delta], center=true);
		// Center opening
		cylinder(r=bearing_608_ir, h=big, center=true);
		// Bearing gap
		translate([0, 0, -bearing_gap]) cylinder(r=bearing_608_or-3, h=big);
		// Cutout for easier bearing removal
		translate([length/2-4, -4, -big/2]) cube([8, 8, big]);
		// Holes for attaching to extrusion
		for (i = [-8, -18]) {
			translate([0, 0, i]) rotate([0, -90, 0]) cylinder(r=screw_r, h=big, center=true);
		}
		// Chop off bottom corner
		translate([-10, 0, -26]) rotate([0, 45, 0]) translate([0, -big/2, 0]) cube([big, big, big]);
	}
}

bearing_holder();
bearing_608();