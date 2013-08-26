include <bearing_608.scad>;
include <config.scad>;

screw_r = 3.0/2;
bearing_base_thickness = 3.5;
height = bearing_608_h+bearing_base_thickness; // height in direction of bearing axis
bearing_width_clearance = 6.0;
width = bearing_608_or*2+bearing_width_clearance; 
length = bearing_608_or*2; // distance sticking out from OpenBeam
cutout_width = 8;
bearing_gap = 0.75; // space to clear bearing motion
extrusion_width = 15;
main_thickness = 3.0;
flange_height = 20;
flange_out = 20;
gap_width = 8;  // width of gap for bearing snap
bearing_608_or_adjust = -0.10;  // grab the bearing a bit tighter.
bounding_cyl_r = bearing_608_or+2.5;
pie_side_clearance = 3.0;  // amount of material on each side of the cutout "center pie"
pie_x_shift = 10;  // amount to shift the pie

big = 100;

delta = 1;

$fn = 128;

module bearing_holder() {
	difference() {
		intersection() {
			// Main body
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
			// Cylinder to reduce interference when effector is close to the tower.
			cylinder(r=bounding_cyl_r, h=big, center=true);
		}
		// Primary bearing cutout
		cylinder(r=bearing_608_or+bearing_608_or_adjust, h=bearing_608_h + delta);
		// Cutout to avoid overly narrow paths
		translate([0, 0, bearing_608_h/2+delta/2]) cube([big, cutout_width, bearing_608_h + delta], center=true);
		// Center opening
		cylinder(r=bearing_608_ir, h=big, center=true);
		// Bearing gap
		translate([0, 0, -bearing_gap]) cylinder(r=bearing_608_or-3, h=big);
		// Gap for end of clip on idler mount
		translate([0, 0, -2.0]) cylinder(r=bearing_608_ir+2, h=big);
		// Cutout for easier bearing removal
		//translate([length/2-4, -4, -big/2]) cube([8, 8, big]);
		// Cutout so that part snaps around bearing
		translate([0, -gap_width/2, -big/2]) cube([big, gap_width, big]);
		// Holes for attaching to extrusion
		for (i = [-7, -20]) {
			translate([0, 0, i]) rotate([0, -90, 0]) cylinder(r=m3_r, h=big, center=true);
		}
		// Chop off bottom corner
		translate([-10, 0, -27]) rotate([0, 36, 0]) translate([0, -big/2, 0]) cube([big, big, big]);
		// "Center pie": Chop off front corner to add extra clearance
		hull() {
			translate([0, 0, -20]) rotate([0, 0, 30]) 
				translate([pie_x_shift, -pie_side_clearance, 0]) cube([big, pie_side_clearance*2, 40]);
			translate([0, 0, -20]) rotate([0, 0, -30]) 
				translate([pie_x_shift, -pie_side_clearance, 0]) cube([big, pie_side_clearance*2, 40]);
		}
		// Chop off a bit more of the front corner to save plastic
		translate([bearing_608_or-4.0, -big/2, -big/2]) cube([big, big, big]); 
	}
}

rotate([0, -90, 0]) bearing_holder();
//bearing_608();