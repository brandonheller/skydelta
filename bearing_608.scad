bearing_608_h = 7.0;
bearing_608_ir = 8.0/2;
bearing_608_or = 25.0/2;
bearing_608_color = [0.7, 0.7, 0.7, 1.0];

delta = 0.1;

module bearing_608() {
	color(bearing_608_color) {
		difference() {
			cylinder(r=bearing_608_or, h=bearing_608_h);
			translate([0, 0, -delta]) cylinder(r=bearing_608_ir, h=bearing_608_h + 2 * delta);
		}
	}
}

//bearing_608();