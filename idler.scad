include <config.scad>;

// These dimensions are all measured from a set of double 623 v-wheels from Steve Graber, which are all one-offs.
// You may want to consider purchasing 623VV's or 624VV's as a replacement. 
idler_or = 15.3/2;
idler_ir = 3.0/2;
idler_h = 11.2;
idler_cut_or = 11.1/2;
idler_cut = idler_or-idler_cut_or;

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