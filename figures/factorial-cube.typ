#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// 2³ factorial design: each vertex is one run, each axis one factor at levels −/+.
// Oblique projection: the canvas draws the z unit vector as (.45, .25).
#cetz.canvas(length: 3cm, z: (.45, .25), {
  import cetz.draw: *
  set-style(stroke: black, mark: (fill: black))

  for x in (0, 1) { for y in (0, 1) { for z in (0, 1) {
    let p = (x, y, z)
    if x == 0 { line(p, (rel: (1, 0, 0))) }
    if y == 0 { line(p, (rel: (0, 1, 0))) }
    if z == 0 { line(p, (rel: (0, 0, 1))) }
    circle(p, radius: 2pt, fill: black, stroke: none)
  } } }

  // Level discs beside the low and high vertex; a line between named
  // elements stops at their borders.
  set-style(content: (frame: "circle", stroke: none, padding: 1.5pt))
  let factor(id, low, high, offset, anchor) = {
    content((rel: offset, to: low), $-$, fill: eastern.transparentize(55%), name: id + "-")
    content((rel: offset, to: high), $+$, fill: orange.transparentize(55%), name: id + "+")
    // The invisible start mark makes `offset` leave a gap at both ends.
    line(id + "-", id + "+", mark: (start: (symbol: "|", stroke: none), end: ">", offset: 4pt))
    content((id + "-", 50%, id + "+"), id, anchor: anchor, frame: none, padding: 4pt)
  }
  factor("A", (0, 0, 0), (1, 0, 0), (0, -.22), "north")
  factor("B", (1, 0, 1), (1, 1, 1), (.2, 0), "west")
  factor("C", (0, 1, 0), (0, 1, 1), (-.2, .2), "south-east")
})
