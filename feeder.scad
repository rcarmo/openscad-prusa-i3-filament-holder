$fn=100;

// Thickness of the metal frame
gap = 7;

module clip() {
    difference() {
        cube([30,2*gap,30], center=true);
        translate([0,0,-gap/2])
            cube([30+1,gap,31], center=true);
    }
    translate([0,-gap*.75,-5])
        cube([30,gap/2,30], center=true);
}


module pipe() {
    difference() {
        cylinder(30, 3.5, 5, center=true);
        cylinder(31, 2, 4, center=true);
    }
}

module platform() {
    translate([15,30,0])
        cylinder(gap/2, 15, 15);
    translate([15,10,0])
        cylinder(gap/2, 15, 15);
    translate([0,10,0])
        cube([30,20,gap/2]);
}

module feeder() {
    difference() {
        union() {
            translate([-15,0,0])
                platform();
            translate([0,20,-12])
                rotate([-15,0,90])
                    clip();
            translate([10,10,0])
                rotate([-45,45,90-27])
                    pipe();
        }
        translate([-45,-45,gap/2-0.1])
           cube([100,100,70]);
        translate([10,10,0])
           rotate([-45,45,90-27])
              cylinder(31, 2, 4, center=true);
    }
}

rotate([180,0,0])
    feeder();