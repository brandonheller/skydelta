include <config.scad>;

idler_or = 11.0/2;
idler_ir = 3.0/2;
idler_h = 9.0;
idler_cut = 2.0;

$fn=32;

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

//idler();