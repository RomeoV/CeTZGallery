#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)
  let hue = eastern
  let border-a1 = bezier.with((0, 0), (2, 5), (1, 2), (3.5, 1))

  circle((4, 2.5), radius: (2.7, 1.7), fill: hue.lighten(80%), stroke: hue.darken(20%), name: "b")
  // The black border of A1 is drawn over the stroke of the intersection.
  boolean(merge-path(close: true, { border-a1(); line((), (0, 5)) }), "b", op: "intersection",
    fill: hue.lighten(25%), stroke: hue.darken(20%))
  rect((0, 0), (8, 5))
  border-a1()
  // Boundaries between the remaining events, as (start, end, control 1, control 2).
  for (a, b, c1, c2) in (
    ((0, 5), (2, 0), (1, 1), (3, 1)),
    ((3, 0), (2, 5), (2, 1), (4, 1)),
    ((4, 5), (5, 0), (2, 4), (4, 1)),
    ((4, 0), (8, 0), (3, 4), (4, 4)),
    ((5, 5), (6, 0), (3, 4), (4, 3)),
    ((7, 5), (6, 0), (7, 4), (8, 3)),
  ) { bezier(a, b, c1, c2) }

  content((1.88, 2.5), text(8.5pt, $A_1 inter B$))
  content((6, 4), text(hue.darken(20%), $B$))
  for (pos, label) in (
    ((1, 4), $A_1$), ((0.7, 2), $A_2$), ((2.5, 2), $A_3$), ((1.5, 0.5), $A_4$),
    ((3.3, 0.3), $A_5$), ((4.2, 2), $dots.c$), ((7, 0.3), $A_(n-1)$), ((7.5, 2), $A_n$),
  ) { content(pos, label) }
})
