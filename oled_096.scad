// oled_096.scad - OLED 0.96" screen in OpenSCAD
$fn=100;


Height = 5;     // Bottom of PCB
Slop = 0.1;     // Fitment slop

// PCB parameters
L = 43.18;      // PCB Length
W = 17.78;      // PCB Width
T = 1.6;        // PCB Thickness
Hole = 1.77;    // Hole size
Offset = 1.27;  // Hole offset from edge

// Mount parameters
Mnt_Lip = 3;
Mnt_H = Height + T + 1;
Mnt_L = L + Mnt_Lip/2;
Mnt_W = W;
Mnt_T = 2; 

//nano();
//nano_mount();

module nano() {
    
    translate([0, Mnt_T/2, 0]) {
    
        translate([3, W/2, Height+T+2])
            rotate([0,180,270])
                %import("587.stl", convexity =4);
    
        difference() {
            // PCB
            translate([0, 0, Height])
                %cube([L, W, T]);

            // Holes
            translate([L-Offset, W-Offset, Height+T/2])
                %cylinder(h = 2*T, d = Hole, center = true);
            translate([L-Offset, Offset, Height+T/2])
                %cylinder(h = 2*T, d = Hole, center = true);
            translate([Offset, W-Offset, Height+T/2])
                %cylinder(h = 2*T, d = Hole, center = true); 
            translate([Offset, Offset, Height+T/2])
                %cylinder(h = 2*T, d = Hole, center = true); 
        }
    }
}

module nano_mount() {
    difference() {
        union() {
        // Create 1st side
        translate([0, Mnt_W, 0])
            cube([Mnt_L, Mnt_T, Mnt_H]);
        // Create 2nd side    
        translate([0, 0, 0])
            cube([Mnt_L, Mnt_T, Mnt_H]);
        }
        
        // Remove PCB slot
        translate([-Slop, Mnt_T/2-Slop, Height-Slop])
            cube([L+2*Slop, W+2*Slop, T+2*Slop]);
        
        // Remove section above PCB
        translate([Mnt_Lip, Mnt_T/2-Slop, Height])
            cube([Mnt_L-2*Mnt_Lip+Slop, W+2*Slop, 3*T]);;
        
        // Remove any overhang
        translate([-10, -1, -1])
            cube([10, Mnt_W+Mnt_T+2, Mnt_H+2]);
        
    }
}