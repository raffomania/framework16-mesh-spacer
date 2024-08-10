back_gap = 18.268;
clamp_thickness = 3;
width = 17;
back_clamp_depth = back_gap + clamp_thickness;

difference() {
    cube([width, back_clamp_depth, 12.363]);
    translate([-1, clamp_thickness, clamp_thickness]) cube([width+2, back_gap+1, 20]);
}

ridge_upper_height = 5.126;
ridge_lower_height = 4;
// add 0.6 to compensate for reduced back gap
ridge_depth = 4.503+0.6;
ridge_z_start = 16.901;
ridge_clamp_height = 23.739;
ridge_clamp_depth = ridge_depth + clamp_thickness;
difference() {
    translate([0, back_clamp_depth, 0]) cube([width, ridge_clamp_depth, ridge_clamp_height]);
    translate([0, back_clamp_depth, ridge_z_start]) cube([width, ridge_depth, ridge_upper_height]);
}