#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: (paint: black, thickness: .5pt), mark: (fill: black, scale: .7))
  // Data coordinates (t, f(t)); text, strokes and marks keep their size.
  scale(x: .65, y: 8.5)

  // Student t density for ν = 5: Γ(3) / (√(5π) Γ(5/2)) · (1 + t²/5)^(-3).
  let pdf(t) = 8 / (3 * calc.pi * calc.sqrt(5)) * calc.pow(1 + t * t / 5, -3)
  let curve(a, b) = range(101).map(i => a + (b - a) * i / 100).map(t => (t, pdf(t)))
  let q = 2.015

  line((q, 0), ..curve(q, 5), (5, 0), close: true, stroke: none,
    fill: teal.lighten(20%))
  line(..curve(-5, 5), stroke: (thickness: 1pt))

  rect((-5.5, -.04), (5.5, .42), name: "frame")
  for x in (-4, -2, 0, 2, 4) {
    let p = ((x, 0), "|-", "frame.south")
    line(p, (rel: (0, .01)))
    content(p, $#x$, anchor: "north", padding: 4pt)
  }
  for y in (0, .2, .4) {
    let p = ("frame.west", "|-", (0, y))
    line(p, (rel: (.15, 0)))
    content(p, $#y$, anchor: "east", padding: 4pt)
  }
  content("frame.south-east", $t$, anchor: "north-west", padding: 2pt)
  content("frame.north-west", $f(t)$, anchor: "south-east", padding: 2pt)

  line((.5, pdf(.5)), (rel: (1.2, 0)), stroke: gray, name: "leader")
  content("leader.end", $nu = 5$, anchor: "west", padding: 2pt)

  bezier((q, 0), (3.5, .1), (q, .07), (3.5, .03),
    mark: (start: "stealth", end: "stealth"), name: "callout")
  content("callout.end", $t_alpha = 2.0150$, anchor: "south", padding: 3pt)
})
