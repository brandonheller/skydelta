// Effector Base
// Shared between top and bottom.
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

hotend_radius = 8.06;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;

standoff_r = 8.5/2;
standoff_offset = effector_body_r + standoff_r;  // XY offset from center
standoff_offset_deg = 18;  // rotation offset relative to line between center and screw hole
standoff_increment_deg = 2;  // increment in degrees for between-standoff-mount material
standoff_flange_offset = effector_body_r + 1;
standoff_flange_r = 4;

filament_exit_offset = effector_body_r + 2.0;
filament_exit_r = 2.0/2;
filament_path_r = 1.2/2;
filament_path_fn = 4; // square hole

module effector_base() {
	difference() {
		union() {
			// Main body
			cylinder(r=effector_body_r, h=height, center=true, $fn=128);
			for (a = [0:120:359]) rotate([0, 0, a]) {
				// Standoff mounts
				for (b = [-1, 1]) rotate([0, 0, b * standoff_offset_deg]) {
					hull() {
	 					translate([0, standoff_offset, 0]) cylinder(r=standoff_r, h=height, center=true, $fn=64);
	 					translate([0, standoff_offset-10, 0]) cylinder(r=standoff_r, h=height, center=true, $fn=32);
					}
				}
				// Extra material between standoff mounts to attach filament tunnel.
				for (b = [-standoff_offset_deg:standoff_increment_deg:standoff_offset_deg-standoff_increment_deg]) {
					hull() {
						rotate([0, 0, b])
		 					translate([0, standoff_flange_offset, 0]) cylinder(r=standoff_flange_r, h=height, center=true, $fn=32);
						rotate([0, 0, b+standoff_increment_deg])	
							translate([0, standoff_flange_offset, 0]) cylinder(r=standoff_flange_r, h=height, center=true, $fn=32);	
					}
				}
	  		}
		}
		// Holes in standoff mounts
		for (a = [0:120:359]) rotate([0, 0, a]) {
			for (b = [-1, 1]) rotate([0, 0, b * standoff_offset_deg]) {
				// Through hole
				translate([0, standoff_offset, 0]) cylinder(r=m3_r, h=height+2*delta, center=true, $fn=32);
				// Screw head hole
				translate([0, standoff_offset, height/2-m3_cap_h]) cylinder(r=m3_cap_r, h=m3_cap_h+delta, $fn=32);
			}
		}
		// Filament tie-down path, in two parts
		for (a = [0:120:359]) rotate([0, 0, a]) {
			translate([0, filament_exit_offset, 0]) {
				// Side entrance
				rotate([-90, 0, 0]) cylinder(r=filament_path_r, h=10, $fn=filament_path_fn);
				// Vertical exit
				cylinder(r=filament_exit_r, h=height+2*delta, $fn=32, center=true);
			}
		}
	}
}

//effector_base();