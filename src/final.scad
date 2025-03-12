use <origami.scad>

DIAGRAM_SIZE = 70;

origami_level(3) { // There are now 2 layers below this one
    square_paper(DIAGRAM_SIZE/2, DIAGRAM_SIZE/2);

    crease(0, 0, DIAGRAM_SIZE/2, DIAGRAM_SIZE/2);
}
