// Defines dimensions shared between single and double idlers.
include <bearing_608.scad>;
include <idler.scad>;

screw_r = 3.0/2;
bearing_ir = 8.0/2;
inside_bearing_thickness = 2.0;
inside_bearing_h = 4.0;
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

$fn=32;
