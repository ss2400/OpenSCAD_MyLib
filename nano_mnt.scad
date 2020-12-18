// nano_mnt.scad - Arduino Nano Mount in OpenSCAD

include <NopSCADlib/lib.scad>

$fn=100;

// PCB dimensions
L = 43.18;      // PCB Length
W = 17.78;      // PCB Width
T = 1.6;        // PCB Thickness
Hole = 1.77;    // Hole size
Offset = 1.27;  // Hole offset from edge

Post = 5;       // Post thickness (except with screw)
Screw = 2;      // Screw size
Slop = 0.15;    // Fitments slop

// Examples
nano(h=10);
nano_mount(h=10);
translate([-4,-4,0])
  cube([54,26,2]);

module nano(h=5) {
  translate([0, 0, 0]) {
  
    translate([3, W/2, h+T+2])
      rotate([0,180,270])
        %import("models/587.stl", convexity=4);
  
    difference() {
      // PCB
      translate([0, 0, h])
        %cube([L, W, T]);

      // Holes
      translate([L-Offset, W-Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
      translate([L-Offset, Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
      translate([Offset, W-Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true); 
      translate([Offset, Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true); 
    }
  }
}

module nano_mount(h=5) {
	// Mount parameters
	Mnt_H = h + T*2;
	Mnt_L = L;
	Mnt_W = W;

  difference() {
    union() {
      // Create front
      translate([0, 0, 0])
        rounded_cylinder(r=Post/2, h=Mnt_H, r2=0.5, ir=0, angle=360);
      translate([0, Mnt_W, 0])
        rounded_cylinder(r=Post/2, h=Mnt_H, r2=0.5, ir=0, angle=360);
        
      // Create rear
      translate([Mnt_L, 0, 0])
        rounded_cylinder(r=Post/2, h=h+T, r2=0.5, ir=0, angle=360);
      translate([Mnt_L, Mnt_W, 0])
        rounded_cylinder(r=Post/2, h=h+T, r2=0.5, ir=0, angle=360);
        
      // Screw post
      translate([Mnt_L+Screw/2+Slop, Mnt_W/2, 0])
        rounded_cylinder(r=Screw+1, h=h+T, r2=0.5, ir=Screw/2, angle=360);
    }
    
    // Remove PCB section
    translate([Slop, -Slop, h])
      cube([Mnt_L+Slop*2, Mnt_W+Slop*2, T+Slop]);;
  }  
}
