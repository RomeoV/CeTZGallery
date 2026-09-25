#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)
// Based on https://tex.stackexchange.com/a/29367 by Jake, CC BY-SA 3.0.

#let hue = eastern.darken(15%)
// Diagonal hatch with period `d`; lines overshoot the tile so that butt caps do not notch the corners.
#let hatch(d, thickness) = tiling(size: (d, d), for c in (0pt, d, 2 * d) {
  place(line(start: (c + d, -d), end: (-d, c + d), stroke: thickness + hue))
})

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: .6pt + black)
  // Data coordinates (z, φ(z)).
  scale(x: .7, y: 9)

  let pdf(z) = calc.exp(-z * z / 2) / calc.sqrt(2 * calc.pi)
  let curve(a, b) = range(101).map(i => a + (b - a) * i / 100).map(z => (z, pdf(z)))

  rect((-6, -.04), (6, .44), name: "frame")
  for x in range(-6, 7, step: 2) {
    let p = ((x, 0), "|-", "frame.south")
    line(p, (rel: (0, .01)))
    line((p, "|-", "frame.north"), (rel: (0, -.01)))
    content(p, $#x$, anchor: "north", padding: 3pt)
  }
  for y in (0, .2, .4) {
    let p = ("frame.west", "|-", (0, y))
    line(p, (rel: (.12, 0)))
    line((p, "-|", "frame.east"), (rel: (-.12, 0)))
    content(p, $#y$, anchor: "east", padding: 3pt)
  }
  content((rel: (0, -.05), to: "frame.south"), $z$, anchor: "north")

  // Each series with its legend row.
  for (i, (fill, label, (a, b))) in (
    (hatch(10pt, 2pt), [Interval 1], (0, 1)),
    (hatch(5pt, .75pt), [Interval 2], (-2, -.5)),
    (none, $phi(z)$, (-5, 5)),
  ).enumerate() {
    let p = (rel: (-2.8, -.035 - .04 * i), to: "frame.north-east")
    if fill == none {
      line(..curve(a, b), stroke: 1pt)
      line((rel: (-.7, 0), to: p), p, stroke: 1pt)
    } else {
      line((a, 0), ..curve(a, b), (b, 0), close: true, fill: fill, stroke: hue)
      rect((rel: (-.7, -.012), to: p), (rel: (0, .012), to: p), fill: fill, stroke: hue)
    }
    content(p, label, anchor: "west", padding: 3pt)
  }
})
