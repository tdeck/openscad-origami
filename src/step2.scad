use <common.scad>
use <braille-chars/ueb.scad>

DIAGRAM_SIZE = 70;

base_plate(DIAGRAM_SIZE, DIAGRAM_SIZE);

square_outline(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);
crease(0, DIAGRAM_SIZE/2, DIAGRAM_SIZE, DIAGRAM_SIZE/2); // Horizontal line
crease(DIAGRAM_SIZE/2, 0, DIAGRAM_SIZE/2, DIAGRAM_SIZE); // Vertical line

translate([5, 2, 0]) braille_label(["B", "T", "M"], lie_flat=true, plate_thickness=0);
