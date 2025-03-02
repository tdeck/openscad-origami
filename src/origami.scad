use <braille-chars/ueb.scad>

BASE_THICKNESS = 1;
LINE_HEIGHT = .6;

LINE_WIDTH = 1;
THIN_LINE_WIDTH = .4;
DASH_LENGTH = 4;
DASH_SPACING = 3;
DOT_SPACING = 2.5;
DOT_LENGTH = LINE_WIDTH;

OUTLINE_PAGES = true; // Whether pages should have a raised outer outline or not

CREASE_END_OFFSET = 5; // Crease doesn't go all the way to the edge

//
// Control functions
//

module origami_level(n) {
    // Sets the base height and surface feature level for origami library
    $origami_level = n;
    children();
}

module primitive() {
    // Raises non-Origami objects that would be flat at z=0 to the base level
    _surface_level() { children(); }
}

//
// Bases
//

module square_paper(width, length) {
    // Edges
    if (OUTLINE_PAGES) {
        _surface_level() _to_3d() difference() {
            square([width, length]);
            offset(delta=-LINE_WIDTH) square([width, length]);
        }
    }

    // Base
    linear_extrude(BASE_THICKNESS * _olevel()) {
        square([width, length]);
    }
}

module polygon_paper(points) {
    // Edges
    if (OUTLINE_PAGES) {
        _surface_level() _to_3d() difference() {
            polygon(points);
            offset(delta=-LINE_WIDTH) polygon(points);
        }
    }

    // Base
    linear_extrude(BASE_THICKNESS * _olevel()) {
        polygon(points);
    }
}

//
// Surface elements
//

module surface_braille(x, y, chars) {
    _surface_level() translate([x, y, 0]) braille_label(chars, lie_flat=true, plate_thickness=0);
}

module solid_line(startx, starty, endx, endy) {
    _surface_level() _to_3d() {
        hull() {
            translate([startx, starty]) circle(d=LINE_WIDTH);
            translate([endx, endy]) circle(d=LINE_WIDTH);
        }
    }
}

module crease(startx, starty, endx, endy) {
    x1_offset = startx + cos(atan2(endy - starty, endx - startx)) * CREASE_END_OFFSET;
    y1_offset = starty + sin(atan2(endy - starty, endx - startx)) * CREASE_END_OFFSET;
    x2_offset = endx - cos(atan2(endy - starty, endx - startx)) * CREASE_END_OFFSET;
    y2_offset = endy - sin(atan2(endy - starty, endx - startx)) * CREASE_END_OFFSET;
    _surface_level() _to_3d() {
        hull() {
            translate([x1_offset, y1_offset]) circle(d=THIN_LINE_WIDTH);
            translate([x2_offset, y2_offset]) circle(d=THIN_LINE_WIDTH);
        }
    }
}

module mountain_fold(startx, starty, endx, endy) {
    // This produces a dash-dot-dot line
    _surface_level() _to_3d() dashed_dotted_line(startx, starty, endx, endy);
}

module valley_fold(startx, starty, endx, endy) {
    // This produces a dashed line
    _surface_level() _to_3d() dashed_line(startx, starty, endx, endy);
}

//
// Internal functions
//
function _olevel() = is_undef($origami_level) ? 1 : $origami_level;

module _to_3d() {
    linear_extrude(LINE_HEIGHT) { children(); }
}


module _surface_level() {
    translate([0, 0, _olevel() * BASE_THICKNESS]) { children(); }
}


//
// ChatGPT written code below
//
module dashed_line(x1, y1, x2, y2, dash_length=DASH_LENGTH, dash_spacing=DASH_SPACING, line_width=LINE_WIDTH) {
    d = sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1)); // Total line length
    theta = atan2(y2 - y1, x2 - x1); // Angle of the line
    num_dashes = ceil(d / (dash_length + dash_spacing));
    
    for (i = [0 : num_dashes - 1]) {
        t1 = i * (dash_length + dash_spacing);
        t2 = min(t1 + dash_length, d);
        
        x_start = x1 + cos(theta) * t1;
        y_start = y1 + sin(theta) * t1;
        x_end = x1 + cos(theta) * t2;
        y_end = y1 + sin(theta) * t2;
        
        hull() {
            translate([x_start, y_start]) circle(d=line_width);
            translate([x_end, y_end]) circle(d=line_width);
        }
    }
}

module dashed_dotted_line(x1, y1, x2, y2, dash_length=DASH_LENGTH, dot_length=DOT_LENGTH, dash_spacing=DASH_SPACING, dot_spacing=DOT_SPACING, line_width=LINE_WIDTH) {
    d = sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1)); // Total line length
    theta = atan2(y2 - y1, x2 - x1); // Angle of the line
    pattern_length = dash_length + dash_spacing + dot_length + dot_spacing + dot_length + dash_spacing;
    num_patterns = ceil(d / pattern_length);
    
    for (i = [0 : num_patterns - 1]) {
        t1 = i * pattern_length;
        t2 = min(t1 + dash_length, d);
        t3 = min(t2 + dash_spacing, d);
        t4 = min(t3 + dot_length, d);
        t5 = min(t4 + dot_spacing, d);
        t6 = min(t5 + dot_length, d);

        t34 = (t3 + t4) / 2;
        t56 = (t5 + t6) / 2;
        
        x_dash_start = x1 + cos(theta) * t1;
        y_dash_start = y1 + sin(theta) * t1;
        x_dash_end = x1 + cos(theta) * t2;
        y_dash_end = y1 + sin(theta) * t2;
        
        x_dot1 = x1 + cos(theta) * t34;
        y_dot1 = y1 + sin(theta) * t34;
        x_dot2 = x1 + cos(theta) * t56;
        y_dot2 = y1 + sin(theta) * t56;
        
        hull() {
            translate([x_dash_start, y_dash_start]) circle(d=line_width);
            translate([x_dash_end, y_dash_end]) circle(d=line_width);
        }
        hull() {
            translate([x_dot1, y_dot1]) circle(d=line_width);
        }
        hull() {
            translate([x_dot2, y_dot2]) circle(d=line_width);
        }
    }
}
