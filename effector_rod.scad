// Effector Rod attachment
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

flange_height = 4;
tube_or = 8.0/2;
tube_surround_r = tube_or + 1.5;
height = 20;
rib_width = 2;

module effector_rod() {
	difference() {
		intersection() {
			union() {
				// Main body
				cylinder(r=effector_body_r, h=flange_height, $fn=128);
				// Center solid tunnel
				cylinder(r=tube_surround_r, h=height, $fn=64);
				// "Ribs"
				for (a = [0:60:359]) rotate([0, 0, 30+a]) {
	 				translate([0, mount_radius, 0]) cube([rib_width, big, big], center=true, $fn=24);
	  			}
			}
			// Outer cone shape to trim ribs
			cylinder(r1=effector_body_r+2, r2=tube_surround_r, h=height, $fn=128);
			// Restrict to the main body cylinder
			cylinder(r=effector_body_r, h=height, $fn=128);
		}
		// Screw cutout
		translate([0, 0, 0]) cylinder(r=tube_or, h=big, center=true);
		// Mounting holes
		for (a = [0:60:359]) rotate([0, 0, a]) {
	 		translate([0, mount_radius, 0]) cylinder(r=m3_r, h=big, center=true, $fn=24);
	  	}
	}
}

effector_rod();