#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#let accent = teal.darken(45%)

#cetz.canvas({
  import cetz.draw: *
  set-style(
    stroke: 0.6pt + black,
    mark: (end: "stealth", fill: black, scale: 0.8),
    content: (padding: 0.08),
  )

  // Cubic curve leaving `a` and entering `b` at `angle` to the chord, like TikZ `bend left`.
  let bend(a, b, angle) = bezier(a, b, (a, 40%, angle, b), (b, 40%, -angle, a))

  rect((0, 0), (rel: (2.7, 1.1)), radius: 0.15, stroke: accent, name: "sys")
  content("sys", text(accent)[System])

  let inputs = (x1: $x_1$, x2: $x_2$, x3: $x_3$, dots: $dots.v$, xk: $x_k$)
  for (i, (name, x)) in inputs.pairs().enumerate() {
    content((rel: (-1.1, (2 - i) * 0.55), to: "sys.west"), x, name: name)
  }
  bend("x1.east", (name: "sys", anchor: 120deg), 45deg)
  bend("x2.east", (name: "sys", anchor: 162deg), 15deg)
  line("x3", "sys")
  bend("xk.east", (name: "sys", anchor: 240deg), -45deg)

  circle((rel: (0.8, 0), to: "sys.east"), radius: 0.28, anchor: "west",
    fill: teal.lighten(50%), name: "y")
  content("y", $y$)
  line("sys", "y")

  set-style(content: (wrap: text.with(8pt, accent)))
  content((rel: (-0.1, 0), to: "x3.west"), [stimuli], angle: 90deg, anchor: "south")
  content((rel: (0.1, 0), to: "y.east"), [response], angle: -90deg, anchor: "south")
})
