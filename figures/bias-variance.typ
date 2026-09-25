#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// Linear congruential generator mapped to [-1, 1); Typst has no random numbers.
#let uniform(seed, n) = {
  let m = calc.pow(2, 31)
  let s = seed
  for _ in range(n) {
    s = calc.rem(1103515245 * s + 12345, m)
    (2 * s / m - 1,)
  }
}

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)

  let panel(name, origin, aim, spread, ring, seed) = group(name: name, {
    translate(origin)
    for r in (2.5, 2, 1.5, 1, 0.5, 0.05) {
      circle((0, 0), radius: r, fill: black.transparentize(85%))
    }
    for (dx, dy) in uniform(seed, 40).chunks(2) {
      circle((rel: (spread * dx, spread * dy), to: aim), radius: 2pt, fill: orange)
    }
    circle(aim, radius: ring, stroke: green.darken(20%))
    content(aim, text(green.darken(30%), $times$))
    line((-2.65, -2.75), (rel: (5.25, 0)))
    line((2.75, 2.65), (rel: (0, -5.25)))
  })
  let header(pos, body, ..args) = content(pos, ..args, padding: 0.1,
    box(width: 5.25cm, inset: 4pt, fill: silver.lighten(40%), stroke: 0.6pt, align(center, body)))

  let cols = (([Unbiased], (0, 0)), ([Biased], (1.25, 0.5)))
  let rows = (([High variance], 1, 1.15), ([Low variance], 0.5, 0.65))
  for (j, (row, spread, ring)) in rows.enumerate() {
    for (i, (col, aim)) in cols.enumerate() {
      let name = "p" + str(i) + str(j)
      panel(name, (5.5 * i, -5.5 * j), aim, spread, ring, 1 + 2 * j + i)
      if i == 0 { header(name + ".west", row, angle: 90deg, anchor: "south") }
      if j == 0 { header(name + ".north", col, anchor: "south") }
    }
  }
})
