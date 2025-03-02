use <origami.scad>

// This is a simple triangular origami hat concept

origami_level(1) { // Bottom "brim" of the hat
    square_paper(80, 20);
    // Crease will be hidden so I don't draw it
}

origami_level(2) { // Triangular hat peak
    polygon_paper([[0, 0], [40, 60], [80, 0]]);
    crease(40, 0, 40, 60);
}

origami_level(3) { // Top "brim" of the hat
    square_paper(80, 20);
    crease(40, 0, 40, 20);
}
