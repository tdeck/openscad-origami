# Tactile origami diagrams using OpenSCAD

This is a prototype to explore the idea of drawing tactile origami diagrams using OpenSCAD and [3DMake](https://github.com/tdeck/3dmake). The diagrams are essentially flat, with raised elements that follow these conventions:

- **Mountain fold**: Dash-dot-dot line
- **Valley fold**: Dashed line
- **Crease**: Thin line that doesn't go all the way to the edge
- Optionally, the paper's outline can be raised (set `OUTLINE_PAGES = false` in origami.scad to turn this off)

## Files

The actual origami drawing functions are in src/origami.scad. step1, step2, step3, and final show the process of folding a base square. The hat.scad shows what a simple origami hat's finished diagram might look like.

These are licensed under the MIT license. Feel free to copy this and make it into something better!

## Drawing functions

These diagrams have two levels: a solid, thin base representing the sheet of paper, and a set of raised lines and Braille labels. To create the base, use the `square_paper()` module like this:

```
square_paper(100, 100); // A 10x10cm square
```

For more complex shapes (i.e. already partially folded origami models) you can use a polygon to define the base shape. The `polygon_paper()` takes a list of x,y coordinate pairs that will make a polyon by creating an edge between each of the points in order (the last point will be connected to the first point).
```
// Below: A triangle with base=100 and height = 50
polygon_paper([[0,0], [50, 100], [100, 0]]);

// Below: A square with a triangle sticking out of the right side
polygon_paper([[0,0], [100, 0], [150, 50], [100, 100], [0, 100]]);
```

To draw folds on the surface, you can use the `mountain_fold()`, `valley_fold()` and `crease()` functions. Each takes for arguments as `(x1, y1, x2, y2)` and draws a line of the appropriate type between that pair of coordinates. There is also the `surface_braille()` function. This takes the x,y coordinates of the lower left corner of the braille label, and a list of characters to write. See [the braille-chars library documentation](https://github.com/tdeck/3dmake_libraries/tree/main/braille-chars#braille-chars---braille-for-openscad) to understand what characters you can put in that list.

The origami drawing functions have the notion of being on a particular "layer", so that you can have partially covered up lower layers of a paper printed at different heights. To put all the elements in a particular layer, put them inside the `origami_level()` module like this:

```
origami_level(1) {
    square_paper(80, 20);
    // Crease will be hidden so I don't draw it
}

origami_level(2) {
    polygon_paper([[0, 0], [40, 60], [80, 0]]);
    crease(40, 0, 40, 60);
}
```


## Conclusion

This prototype is inspired by Lindy at [Accessible Origami](https://www.accessorigami.com/) and is meant to help start the conversation about how these diagrams might be created and shared using 3D printing. I'm not knowledgeable about origami, and I'mn sure there are better ways to represent some of these concepts. There are also more primitives shapes, such as arrows, that would likely be useful.
