// Test piece to try out different sizes and shapes for printed, straight-through, "filament tubes"
include <config.scad>;
include <filament_tube.scad>;

spacing = 5;
group_spacing = 1.5;

filament_start = 0.45/2;
filament_step = 0.05/2;
filament_increments = 8;

width = filament_increments*spacing+2;
len = 4;
height = 8;

module test_block() {
	difference() {
		union() {
			translate([0, 0, 0]) cube([width, len, height]);
			translate([0, len/2, height/4]) sphere(r=1, $fn=10);
		}
		for (i = [0:filament_increments-1]) {
			for (j = [0, 1]) {
				for (k = [0, 1]) {
					translate([(i+0.5)*spacing + j*group_spacing, -delta,  k*group_spacing]) {
						translate([0, 0, height*0.15]) rotate([-90, 0, 0]) cylinder(r=filament_start+filament_step*i, h=len+2*delta, $fn=32);
						translate([0, 0, height*0.65]) rotate([-90, 0, 0]) cylinder(r=filament_start+filament_step*i, h=len+2*delta, $fn=4);
					}
				}
			}
		}
	}
}

test_block();