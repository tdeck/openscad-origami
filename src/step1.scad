use <common.scad>
use <braille-chars/ueb.scad>

DIAGRAM_SIZE = 70;

base_plate(DIAGRAM_SIZE, DIAGRAM_SIZE);

square_outline(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);
crease(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);
crease(0, DIAGRAM_SIZE, DIAGRAM_SIZE, 0);

// Braille "TOP" label
translate([DIAGRAM_SIZE/2 - 10, 2, 0]) braille_label(["T", "O", "P"], lie_flat=true, plate_thickness=0);
