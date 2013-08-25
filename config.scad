delta = 0.1;  // Arbitrary small value to eliminate coincident-face visual artifcats.
big = 1000;  // Arbitrary large value to easy modeling of large stuff (usually for difference'ing).

// Plastic colors
red = [1.0, 0, 0];  // bright red
black = [0.25, 0.25, 0.25];  // dark, but not too dark to show reflections
color = red;

// Screws/nuts
m3_r = (3.0+0.15)/2; // A little slop to reduce need to drill out.  Use high $fn values.

// Effector key dimensions
effector_body_r = 18;  // Main cylinder radius.  Kossel Mini compatible.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.  Kossel Mini compatible.
