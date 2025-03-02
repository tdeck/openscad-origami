use <origami.scad>

DIAGRAM_SIZE = 70;

square_paper(DIAGRAM_SIZE, DIAGRAM_SIZE);
crease(0, DIAGRAM_SIZE/2, DIAGRAM_SIZE, DIAGRAM_SIZE/2); // Horizontal line
crease(DIAGRAM_SIZE/2, 0, DIAGRAM_SIZE/2, DIAGRAM_SIZE); // Vertical line

surface_braille(5, 2, ["B", "T", "M"]);
