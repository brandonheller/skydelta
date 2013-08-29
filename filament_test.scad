// Test piece to try out different sizes and shapes for printed "filament tubes"

width = 27;
len = 8;
height = 6;

path_r = 4;
filament_r = 0.45;//0.5/2;

spacing = 3; //width / 5;
path_circle_fn = 64;
circle_fn = 32;

square = 4;
hexagon = 6;
octagon = 8; 
circle = circle_fn;
paths = [square, hexagon, octagon, circle];
cross_sections = [square, circle];

square_factor = sqrt(2);  // factor to enlarge a diamond to fit a square

// Order, circle_r, path, circle, rotation
rings = [
[1, filament_r * square_factor, square, square, 45],
[2, filament_r, square, circle, 45],
[3, filament_r * square_factor, hexagon, square, 30],
[4, filament_r, hexagon, circle, 30],
[5, filament_r * square_factor, octagon, square, 22.5],
[6, filament_r, octagon, circle, 22.5],
[7, filament_r * square_factor, circle, square, 0],
[8, filament_r, circle, circle, 0],
];

module curved_path(path_r, circle_r, path_fn = 3, circle_fn = 3, rotation = 0) {
	rotate([rotation, 0, 0]) rotate([0, 90, 0])
		rotate_extrude(convexity = 10, $fn = path_fn)
			translate([path_r, 0, 0]) circle(r = circle_r, $fn = circle_fn);
}

module rings(path_r) {
	for (l = rings) {
		assign(i=l[0], cr=l[1], p=l[2], c=l[3], r=l[4]) {
			echo("i =", i, " cr=", cr, " p=", p, " c=", c, " r=", r);
			#translate([spacing*i, 0, 0])
				curved_path(path_r, cr, p, c, r);
		}
	}
}

module test_block() {
	difference() {
		union() {	
			translate([0, 0, 0]) cube([width, len, height]);
			translate([0, len/2, height/2]) sphere(r=1, $fn=10);
		}
		translate([0, 0, height]) rings(path_r);
	}
}

test_block();