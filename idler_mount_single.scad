// Idler mount; rotates to follow the line as the effector moves.

include <bearing_608.scad>;
include <idler.scad>;
include <idler_mount.scad>;

module idler_mount() {
	difference() {
		intersection() {
			union() {
				// Main body
				translate([0, 0, -inside_bearing_h]) cylinder(r=bearing_608_ir, h=inside_bearing_h);
				translate([0, 0, 0]) cylinder(r1=bearing_608_ir, r2=outer_cyl_r, h=taper_h);
				translate([0, 0, taper_h]) cylinder(r=outer_cyl_r, h=outer_cyl_h);
				translate([0, 0, taper_h+outer_cyl_h]) cylinder(r1=outer_cyl_r, r2=bearing_608_ir, h=taper_h);
				translate([0, 0, taper_h+outer_cyl_h+taper_h]) cylinder(r=bearing_608_ir, h=inside_bearing_h);
			}
			// Main body envelope
			union() {
				cube([outer_cube_l, outer_cube_w, big], center=true);
			}	
		}
		// Central vertical hole
		cylinder(r=bearing_608_ir-inside_bearing_thickness, h=big, center=true);
		// Hole for idler screw
		translate([idler_filament_r, 0, taper_h+outer_cyl_h/2]) rotate([90, 0, 0]) cylinder(r=screw_r, h=big, center=true);
		// Slot for idler
		difference() {
			translate([0, 0, taper_h+outer_cyl_h/2]) cube([big, idler_h+idler_clearance*2, idler_or*2+idler_clearance], center=true);
			// Bosses for idler
			for(i = [-1, 1])
				translate([idler_filament_r, i*(idler_h/2+idler_boss_gap), taper_h+outer_cyl_h/2])
					rotate([i*-90, 0, 0]) cylinder(r1=idler_boss_ir, r2=idler_boss_or, h=idler_clearance-idler_boss_gap+delta);
		}
		// Extra material removal; simply not needed on back.
		translate([-13, 0, 0]) cube([20, big, big], center=true);
		// Missing chunk enables clipping into bearing
		for(h = [-bearing_608_h-delta, taper_h+outer_cyl_h]) {
			translate([-big/2, -clip_gap/2, h]) cube([big, clip_gap, bearing_608_h+delta]);
		}
	}
}

module idler_mount_assembly() {
	translate([0, 0, -bearing_608_h]) bearing_608();
	translate([0, 0, taper_h+outer_cyl_h+taper_h]) bearing_608();
	translate([idler_filament_r, 0, taper_h+outer_cyl_h/2]) rotate([90, 0, 0]) color(idler_color) idler();
	idler_mount();
}

//idler_mount_assembly();