include <bearing_608.scad>;

// Idler mount; rotates to follow the line as the effector moves.
screw_r = 3.0/2;
bearing_ir = 8.0/2;
inside_bearing_thickness = 2.0;
inside_bearing_h = 4.0;
taper_h = 6.0;
outer_cyl_h = 12.0;
outer_cyl_r = 22.0/2;
idler_or = 11.0/2;
idler_ir = 3.0/2;
idler_h = 9.0;
filament_r = 1.0/2;
idler_cut = 2.0;
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

big = 100;

$fn=32;

delta = 0.1;

module idler_mount() {
	difference() {
		intersection() {
			union() {
				// Main body
				translate([0, 0, -inside_bearing_h]) cylinder(r=bearing_ir, h=inside_bearing_h);
				translate([0, 0, 0]) cylinder(r1=bearing_ir, r2=outer_cyl_r, h=taper_h);
				translate([0, 0, taper_h]) cylinder(r=outer_cyl_r, h=outer_cyl_h);
				translate([0, 0, taper_h+outer_cyl_h]) cylinder(r1=outer_cyl_r, r2=bearing_ir, h=taper_h);
				translate([0, 0, taper_h+outer_cyl_h+taper_h]) cylinder(r=bearing_ir, h=inside_bearing_h);
			}
			// Main body envelope
			union() {
				cube([outer_cube_l, outer_cube_w, big], center=true);
			}	
		}
		// Central vertical hole
		cylinder(r=bearing_ir-inside_bearing_thickness, h=big, center=true);
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
		translate([-14, 0, 0]) cube([20, big, big], center=true);
	}
}

module idler() {
	intersection() {
		difference() {
			cylinder(r=idler_or, h=idler_h, center=true);
			cylinder(r=idler_ir, h=idler_h+2*delta, center=true);
		}
		union() {
			for(i = [-1, 1]) {
				scale([1, 1, i]) 
				cylinder(r1=idler_or-idler_cut, r2=idler_or+10, h=idler_cut+10);
			}
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