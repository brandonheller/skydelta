bearing_608_h = 7.0;
bearing_608_ir = 8.0/2;
bearing_608_or = 22.0/2;
bearing_608_color = [0.7, 0.7, 0.7, 1.0];
bearing_608_countersink_h = 0.5;  // 45-degree countersink height
bearing_608_countersink_r = 0.5;  // added to main IR

delta = 0.1;

$fn=32;

module bearing_608() {
	color(bearing_608_color) {
		difference() {
			cylinder(r=bearing_608_or, h=bearing_608_h);
			translate([0, 0, -delta]) cylinder(r=bearing_608_ir, h=bearing_608_h + 2 * delta);
			translate([0, 0, -delta]) cylinder(r1=bearing_608_ir+bearing_608_countersink_r, r2=bearing_608_ir, h=bearing_608_h+bearing_608_countersink_len);
			translate([0, 0, bearing_608_h+delta]) rotate([180, 0, 0]) cylinder(r1=bearing_608_ir+bearing_608_countersink_r, r2=bearing_608_ir, h=bearing_608_h+bearing_608_countersink_len);
		}
	}
}

//bearing_608();