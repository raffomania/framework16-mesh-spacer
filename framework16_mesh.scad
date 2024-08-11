
// In general, width = X axis, depth = Y axis, height = Z axis

// Thickness of the walls that make up the clamps.
clamp_thickness = 3;
// Width of one part.
// TODO measure this.
width = 20;

// This is the big clamp, gripping the back 
// of the laptop. It's the main mechanism
// keeping the attachment in place at the moment.

// Height of the gap in the big back clamp.
back_clamp_height = 18.268;
// Height of the back clamp including walls.
back_clamp_outer_height = back_clamp_height + clamp_thickness;

module big_back_clamp() {
    difference() {
        cube([width, 12.363, back_clamp_outer_height]);
        translate([-1, clamp_thickness, 0]) cube([width+2, 20, back_clamp_height]);
    }
}

// This is the small clamp, gripping the little
// ridge at the bottom of the laptop.

// Dimensions of the ridge on the laptop.
ridge_upper_depth = 4.526;
ridge_lower_depth = 4;

// add 0.6 to compensate for reduced back gap
ridge_height = 5.103;
ridge_y_start = 17.5;
ridge_clamp_depth = 23.739;
ridge_clamp_height = ridge_height + clamp_thickness;

module small_bottom_ridge_clamp() {
    difference() {
        cube([width, ridge_clamp_depth, ridge_clamp_height]);
        translate([0, ridge_y_start, ridge_clamp_height - ridge_height]) cube([width, ridge_upper_depth, ridge_height]);
        translate([0, ridge_y_start + ridge_upper_depth, ridge_clamp_height - 0.5]) cube([width, 2, 0.5]);
    }
}

mesh_cutout_size = 6;
mesh_cutout_gap = 10;
module mesh_cutouts() {
    for (x=[0:0]) {
        for (y=[0:2]) {
translate([(mesh_cutout_size + mesh_cutout_gap) * x, (mesh_cutout_size + mesh_cutout_gap) * y, 0])         rotate([0, 0, 45]) cube([mesh_cutout_size, mesh_cutout_size, mesh_height]);
        }
    }
    for (x=[0:0]) {
        for (y=[0:2]) {
translate([mesh_cutout_size + (mesh_cutout_size + mesh_cutout_gap) * x, mesh_cutout_size + (mesh_cutout_size + mesh_cutout_gap) * y, 0])         rotate([0, 0, 45]) cube([mesh_cutout_size, mesh_cutout_size, mesh_height]);
        }
    }
}

// Start of the small lip that the front end of the mesh
// wraps around.
lip_depth = 77.9;
lip_clamp_thickness = 1;
lip_height = 1.2;
mesh_depth = lip_depth + lip_clamp_thickness;
mesh_height = 6 + ridge_clamp_height;
mesh_thickness = 3;
module mesh() {
    intersection() { 
        translate([0, 0, -1]) rotate([7, 0, 0]) {
            cube([width, mesh_depth * 3, mesh_thickness]);
            translate([0, 0.4, 2]) rotate([-4, 0, 0]) cube([width, ridge_clamp_depth, 6]);
        }
        difference() {
            cube([width, mesh_depth, mesh_height]);
            translate([width/3, mesh_depth*0.33, 0]) {
                mesh_cutouts();
            }
        }
    };
    translate([0, lip_depth, mesh_height-4]) cube([width, lip_clamp_thickness, 4+lip_height]);
}

translate([0, 0, mesh_height - ridge_clamp_height]) {
    translate([0, 0, ridge_clamp_height]) big_back_clamp();
    small_bottom_ridge_clamp();
}
mesh();
