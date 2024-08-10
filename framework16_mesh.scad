
// In general, width = X axis, depth = Y axis, height = Z axis

// Thickness of the walls that make up the clamps.
clamp_thickness = 3;
// Width of one part.
width = 17;

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
ridge_upper_depth = 5.026;
ridge_lower_depth = 4;

// add 0.6 to compensate for reduced back gap
ridge_height = 4.503 + 0.6;
ridge_y_start = 17;
ridge_clamp_depth = 23.739;
ridge_clamp_height = ridge_height + clamp_thickness;

module small_bottom_ridge_clamp() {
    difference() {
        cube([width, ridge_clamp_depth, ridge_clamp_height]);
        translate([0, ridge_y_start, ridge_clamp_height - ridge_height]) cube([width, ridge_upper_depth, ridge_height]);
        translate([0, ridge_y_start + ridge_upper_depth, ridge_clamp_height - 0.5]) cube([width, 2, 0.5]);
    }
}

translate([0, 0, ridge_clamp_height]) big_back_clamp();
small_bottom_ridge_clamp();
