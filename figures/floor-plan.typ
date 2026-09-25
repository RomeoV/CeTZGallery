#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas(length: 2.5mm, {
  import cetz.draw: *
  set-style(stroke: 0.8pt + black)

  // Walls run counterclockwise from the door hinge to the far door jamb.
  let hinge = (27.3, 0)
  let walls = (hinge, (rel: (1, 0)), (rel: (0, 26.3)), (rel: (-4.7, 0)), (rel: (0, 4.2)),
    (rel: (-20, 0)), (rel: (0, -4.5)), (rel: (-3.6, 0)), (rel: (0, -26)), (rel: (18.3, 0)))
  let bounds = ((0, 0), (28.3, 30.5))

  grid(..bounds, step: 3, shift: (0.8, 2.2), stroke: 0.4pt + gray)
  boolean(rect(..bounds), line(..walls, close: true), op: "difference", fill: white, stroke: none)
  line(..walls, stroke: 1.6pt)

  line(hinge, (rel: (0, 9)), name: "leaf")
  arc("leaf.end", start: 90deg, delta: 90deg, radius: 9, stroke: (dash: "dashed"))

  let piece(origin, angle, body) = group({
    set-style(fill: blue.lighten(60%)); translate(origin); rotate(angle); body })
  piece((0.5, 8.5), -90deg, rect((0, 0), (8, 5)))  // bookcase
  piece((22, 25), 90deg, rect((0, 0), (5, 16.5)))  // low cupboard
  piece((9, 22), -90deg, {
    // desk and drawer unit
    merge-path(close: true, {
      line((0, 0), (rel: (12, 0)), (rel: (0, 14)), (rel: (-6, 0)), (rel: (0, -6)))
      arc((), start: 0deg, delta: -90deg, radius: 2)
      line((), (0, 6))
    })
    rect((6, 14.2), (rel: (6, 4.5)))
  })

  for pos in ((17, 17), (1, 20), (1, 15), (1, 10)) {
    rect(pos, (rel: (4.4, 4.4)), radius: 1, fill: red.lighten(40%))
  }
})
