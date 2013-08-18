// Defines dimensions shared between single and double idlers.
include <bearing_608.scad>;
include <idler.scad>;

screw_r = 3.0/2;
inside_bearing_thickness = 1.8; // Thickness of the mount's inside-bearing tubes.
inside_bearing_h = bearing_608_h;
taper_h = 6.0;
outer_cyl_h = 12.0;
outer_cyl_r = 22.0/2;

filament_r = 1.0/2;
idler_filament_r = idler_or-idler_cut+filament_r;
idler_clearance = 0.75;
outer_wall = 2.5; // thickness of vertical wall
outer_cube_l = 16.0; // longer than outer_cube_w for idler screw
outer_cube_w = idler_h+idler_clearance*2+outer_wall*2; // narrow side of idler mount
idler_boss_gap = 0.15;
idler_boss_ir = 3;
idler_boss_or = idler_boss_ir + idler_clearance;
idler_color = [0, 0, 0, 1];
idler_mount_height = taper_h*2+outer_cyl_h+bearing_608_h*2;

clip_gap = 1.5;
clip_flange_r = bearing_608_ir+0.5;
clip_flange_h = 1.0;
main_extra_r = 0.5+0.5; // Additional body boss, against which flat side of bearing sits.

$fn=32;

module bearing_grip() {
	difference() {
		union() {
			// Clip body
			cylinder(r=bearing_608_ir, h=inside_bearing_h);
			cylinder(r1=clip_flange_r, r2=bearing_608_ir, h=clip_flange_h);
			translate([0, 0, bearing_608_h-clip_flange_h]) cylinder(r1=bearing_608_ir, r2=clip_flange_r, h=clip_flange_h);
		}
		// Missing chunk enables clipping into bearing
		translate([-big/2, -clip_gap/2, -delta]) cube([big, clip_gap, bearing_608_h + 2 * delta]);
	}
}

