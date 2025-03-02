use <common.scad>
use <braille-chars/ueb.scad>

DIAGRAM_SIZE = 70;

base_plate(DIAGRAM_SIZE, DIAGRAM_SIZE);

square_outline(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);

// Valley folds from corners
valley_fold(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);
valley_fold(0, DIAGRAM_SIZE, DIAGRAM_SIZE, 0);

// Mountain folds at cross parallel to edges
mountain_fold(0, DIAGRAM_SIZE/2, DIAGRAM_SIZE, DIAGRAM_SIZE/2); // Horizontal line
mountain_fold(DIAGRAM_SIZE/2, 0, DIAGRAM_SIZE/2, DIAGRAM_SIZE); // Vertical line

// Braille "TOP" label
translate([8, 2,  0]) braille_label(["T", "O", "P"], lie_flat=true, plate_thickness=0);
