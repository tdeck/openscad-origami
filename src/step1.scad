use <origami.scad>

DIAGRAM_SIZE = 70;

origami_level(1) {
    square_paper(DIAGRAM_SIZE, DIAGRAM_SIZE);
    crease(0, 0, DIAGRAM_SIZE, DIAGRAM_SIZE);
    crease(0, DIAGRAM_SIZE, DIAGRAM_SIZE, 0);

    // Braille "TOP" label
    surface_braille(DIAGRAM_SIZE/2 - 10, 2, ["T", "O", "P"]);
}
