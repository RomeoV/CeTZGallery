#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: none)

  let (R, r, d) = (1.7, 1.1, 4.4)
  let root = teal.darken(40%)
  let concept(pos, radius, fill, body, ink: white) = {
    circle(pos, radius: radius, fill: fill)
    content(pos, align(center, text(ink, body)))
  }
  // Tapered bar from the root towards `a` with waist 2w; Typst gradient angles run clockwise.
  let bar(a, fill, w: 0.08) = {
    let side(s) = (
      (a + s * 20deg, R),
      (rel: (a + 180deg - s * 30deg, r), to: (a, d)),
      (rel: (a + s * 90deg, w), to: (a, R + 0.7)),
      (rel: (a + s * 90deg, w), to: (a, d - r - 0.6)),
    )
    let (p, q, c1, c2) = side(-1)
    merge-path(close: true, fill: gradient.linear(root, fill, angle: -a), {
      bezier(..side(1))
      bezier(q, p, c2, c1)
    })
  }

  concept((0, 0), R, root, text(13pt)[Sale price \ of a property])
  for (i, (hue, ink, body)) in (
    (white, black, [Area (m²), \ Bedrooms, \ Garage, \ Pool]),
    (blue, white, [Age, \ Condition, \ Finish]),
    (orange, black, [Location, \ Access, \ Security]),
    (purple, white, [Economic \ indicators]),
  ).enumerate() {
    let a = 180deg - i * 60deg
    let fill = color.mix((root, 60%), (hue, 40%))
    on-layer(-1, bar(a, fill))
    concept((a, d), r, fill, ink: ink, body)
  }
})
