$fn=100;

// Length and radius of the main cylinder 
length = 100;
radius = 15;
// Chop off to have flat sides and print without supports
slice = 50;
// Thickness of the metal frame
gap = 7;

// Hilt shape
hilt_radius = 40;
hilt_thickness = 8;


module holder_clip(depth=45, width=30) {
    difference() {
        cube([width,2*hilt_thickness+gap,depth], center=true);
        translate([0,0,-gap/2])
            cube([width+1,gap,depth+1-5], center=true);
        translate([0,gap,-gap/2-15])
            cube([width+1,gap+3,20], center=true);
    }
    // structural reinforcement
    translate([-width/2,-hilt_thickness-gap/2,depth/2])
        rotate([90,0,90])
            linear_extrude(width)
                polygon([[0,0],[hilt_thickness*1.2, hilt_thickness/2],[2*hilt_thickness+gap,0],[0,0]]);
}

// build a triangular prism
module triangle(side, radius, height) {
    translate([0,radius])
        hull() {
            cylinder(r=radius, h=height);
            for(i = [60,120])
                rotate([0,0,i])
                    translate([side-radius*2,0,0])
                        cylinder(r=radius, h=height);
        }
    }

module holder_top() {
    intersection() {
        rotate([0,27,0]) {
            cylinder(length,radius,radius);
            // top toroid and fillet
            translate([0,0,length-hilt_thickness/2])
                rotate_extrude()
                    translate([radius,0])
                        circle(hilt_thickness/2);
            translate([0,0,length-hilt_thickness*2])
                rotate_extrude()
                    translate([radius,hilt_thickness-0.9,0]) 
                        difference() {
                            square([1,1]);
                            translate([1,0])
                                circle(1);
                        }
            // hilt toroid and fillet
            rotate_extrude()
                translate([hilt_radius,0,0]) 
                    union() {
                        translate([-hilt_radius/2,0])
                            square([hilt_radius,hilt_thickness], center=true);
                        circle(hilt_thickness/2);
                    }
                rotate_extrude()
                    translate([radius+2,hilt_thickness-2,0]) 
                        difference() {
                            square([hilt_thickness/2,hilt_thickness/2], center=true);
                            translate([2,2])
                                circle(4);
                        }
            // Bottom and alternate horizontal holder
            translate([0,-15,-gap*2.5])
                cube([40,30,gap]);
            translate([0,0,-10])
                cylinder(15, radius*.95, radius*.95, center=true);
        }
        // Chop for flat sides
        rotate([0,27,0])
            translate([0,0,length*0.3])
                cube([length,slice/2,length*1.5],center=true);
    }
}
 


module holder() {
    holder_top();
    translate([-20,0,-30])
        rotate([0,0,90])
            holder_clip(width=slice/2);
    translate([-15,slice/4,-35])
        rotate([90,27,0])
            triangle(25,.01,slice/2);
}

rotate([90,0,-27])
    holder();