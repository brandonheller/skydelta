// Simple representation of spool
include <config.scad>;

spool_height = 20;
module spool() {
	color(black) difference() {
		cylinder(r=18.0/2, h=spool_height);
		translate([0, 0, -delta]) cylinder(r=5.0/2, h=spool_height+2*delta); 
	}
}

//spool();