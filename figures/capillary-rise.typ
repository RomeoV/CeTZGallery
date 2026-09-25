#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  import cetz.decorations: brace
  set-style(stroke: .6pt + black, mark: (fill: black, scale: .8), brace: (amplitude: .2, content-offset: .1),
    content: (padding: .1))
  let arrow = line.with(mark: (end: "stealth"))
  let callout(from, to, body, out: 0deg) = {
    bezier(from, to, (rel: (out, .4), to: from), (rel: (-.4, 0), to: to), mark: (end: "stealth"))
    content(to, body, anchor: "west")
  }
  let water = blue.lighten(85%)
  // Tube radius and its foreshortened depth; meniscus contact height and dip; tube top;
  // pool surface and floor.
  let (r, ry, m, dip, top, level, floor) = (1, .4, 3, 1, 4, .25, -1.8)

  rect((-3 * r, floor), (3 * r, level), fill: water, stroke: none)
  line((-3 * r, level + .1), (-3 * r, floor), (3 * r, floor), (3 * r, level + .1))
  rect((-r, 0), (r, m), fill: water, stroke: none)

  for (side, x) in (("left", -r), ("right", r)) {
    line((x, 0), (x, top), name: side)
    line((x, 0), (rel: (0, -.3)), stroke: (dash: "dashed"))
    line((x, top), (rel: (0, .3)), stroke: (dash: "dashed"))
  }
  circle((0, top), radius: (r, ry), stroke: (dash: "dashed"))

  // A quadratic Bézier is an exact parabola; its control point lies on both contact tangents.
  anchor("ctrl", (0, m - 2 * dip))
  anchor("surface", (0, m))
  anchor("contact", (r, m))
  let rim = arc.with("surface", radius: (r, ry), anchor: "origin", start: 0deg)
  circle("surface", radius: (r, ry), fill: blue.lighten(55%), stroke: none)
  rim(delta: 180deg, stroke: (dash: "dashed"))
  merge-path(fill: blue.lighten(70%), {
    rim(delta: -180deg)
    bezier((-r, m), "contact", "ctrl")
  })

  // Surface tension acts along the contact tangent, all around the rim.
  for a in range(0, 360, step: 45) {
    let a = a * 1deg
    arrow((rel: (a, (r, ry)), to: "surface"), (rel: (.5 * calc.cos(a), 1 + .2 * calc.sin(a))))
  }
  line("contact", ("contact", 50%, "ctrl"))
  cetz.angle.angle("contact", "right.start", "ctrl", direction: "near", radius: .9,
    label: $alpha$, label-radius: 125%, mark: (symbol: "stealth", scale: .5),
    name: "alpha")
  callout((rel: (.15, 0), to: "alpha.label"), (rel: (.9, .6), to: "alpha.label"),
    [angle between the \ meniscus and the \ tube wall])

  arrow((0, m - dip - .4), (rel: (0, -1)), stroke: 3pt, name: "weight")
  content("weight.end", $pi r^2 h rho g$, anchor: "north")
  arrow((0, top + .8), (rel: (0, 1)), stroke: 3pt, name: "lift")
  content("lift.end", $2 pi r gamma cos(alpha)$, anchor: "south")

  brace((r + .2, m - dip), (r + .2, level), name: "h")
  content("h.content", $h$, anchor: "west")
  callout((rel: (0, -.25), to: "h.content"), (rel: (.6, -.6), to: "h.content"), [rise],
    out: -90deg)
  brace((0, -.4), (-r, -.4), name: "r")
  content("r.content", $r$, anchor: "north")
  callout((rel: (.2, -.2), to: "r.content"), (rel: (.8, -.5), to: "r.content"), [tube radius])
})
