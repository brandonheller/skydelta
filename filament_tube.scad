// Module places a filament tube with the desired characteristics. 
// See filament_test.scad for examples.

square_factor = sqrt(2);  // factor to enlarge a diamond to fit a square

path_circle_fn = 64;
circle_fn = 32;
square = 4;
hexagon = 6;
octagon = 8; 
circle = circle_fn;

module curved_path(path_r, circle_r, path_fn = 3, circle_fn = 3, rotation = 0) {
	rotate([rotation, 0, 0]) rotate([0, 90, 0])
		rotate_extrude(convexity = 10, $fn = path_fn)
			translate([path_r, 0, 0]) circle(r = circle_r, $fn = circle_fn);
}