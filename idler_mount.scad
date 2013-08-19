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
outer_wall = 3.5; // thickness of vertical wall
outer_cube_l = 18.0; // longer than outer_cube_w (affects width of wall with idler screw)
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

module bearing_body(inside_h, hole_locs) {
	// inside_h is the height of both the gap and the outer cylinder.
	difference() {
		union() {
			translate([0, 0, 0]) cylinder(r1=bearing_608_ir+main_extra_r, r2=outer_cyl_r, h=taper_h);
			translate([0, 0, taper_h]) cylinder(r=outer_cyl_r, h=inside_h);
			translate([0, 0, taper_h+inside_h]) cylinder(r1=outer_cyl_r, r2=bearing_608_ir+main_extra_r, h=taper_h);
		}
		// Slot for idler
		difference() {
			translate([0, 0, taper_h+inside_h/2]) cube([big, idler_h+idler_clearance*2, inside_h], center=true);
			// Bosses for idler
			for(i = [-1, 1]) {
				for (hl = hole_locs) {
					translate([idler_filament_r, i*(idler_h/2+idler_boss_gap), taper_h+hl])
						rotate([i*-90, 0, 0]) cylinder(r1=idler_boss_ir, r2=idler_boss_or, h=idler_clearance-idler_boss_gap+delta);
				}
			}
		}
	}
}

module idler_mount(inside_h, hole_locs) {
	difference() {
		intersection() {
			union() {
				// Main body
				translate([0, 0, -inside_bearing_h]) bearing_grip();
				translate([0, 0, 0]) bearing_body(inside_h, hole_locs);
				translate([0, 0, taper_h+inside_h+taper_h]) bearing_grip();
			}
			// Main body envelope
			union() {
				cube([outer_cube_l, outer_cube_w, big], center=true);
			}
		}
		// Central vertical hole
		cylinder(r=bearing_608_ir-inside_bearing_thickness, h=big, center=true);
		// Hole for idler screw
		for (i = hole_locs) {
			translate([idler_filament_r, 0, taper_h+i]) rotate([90, 0, 0]) cylinder(r=screw_r, h=big, center=true);
		}
		// Extra material removal; simply not needed on back.
		translate([-13, 0, 0]) cube([20, big, big], center=true);
		// Material removal to have a larger filament approach angle
		for (i = hole_locs) {
			hull() {
				translate([idler_filament_r*2, 0, i+taper_h]) rotate([180, 0, 0]) cylinder(r=1.5, h=20);
				translate([idler_filament_r*2 + 10, 0, i+taper_h]) rotate([180, 0, 0]) cylinder(r=1.5, h=20);
			}
		}

	}
}

module idler_mount_assembly(inside_h, hole_locs) {
	//translate([0, 0, -bearing_608_h]) bearing_608();
	//translate([0, 0, taper_h+inside_h+taper_h]) bearing_608();
	for (hole_loc=hole_locs) {
		translate([idler_filament_r, 0, taper_h+hole_loc]) rotate([90, 0, 0]) color(idler_color) idler();
	}
	idler_mount(inside_h, hole_locs);
}

inside_h=idler_or*2+idler_clearance;
//idler_mount(inside_h, [inside_h/2]);