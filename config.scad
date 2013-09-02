delta = 0.1;  // Arbitrary small value to eliminate coincident-face visual artifcats.
big = 1000;  // Arbitrary large value to easy modeling of large stuff (usually for difference'ing).

extrusion_width = 15;
spool_r = 9; // Grabercars Kossel spools are 18mm measured at the center of the filament.

// Plastic colors
red = [1.0, 0, 0];  // bright red
black = [0.25, 0.25, 0.25];  // dark, but not too dark to show reflections
color = red;

// Screws/nuts
m3_r = (3.0+0.15)/2;  // A little slop to reduce need to drill out.  Use high $fn values.
m3_nut_r = (6.18+0.25)/2;
m3_nut_h = 2.5;
m3_screw_head_r = 6.5/2;
m3_thread_r = (3.0-0.5)/2; // Tight fit for thread-forming.
m3_cap_r = (5.0+0.3)/2;  // SHCS cap radius.
m3_cap_h = 3.0;  // SHCS cap height.
m3_thread_r = (2.8)/2;

// Effector key dimensions
effector_body_r = 18;  // Main cylinder radius.  Kossel Mini compatible.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.  Kossel Mini compatible.
