#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)
// Based on https://tex.stackexchange.com/a/53795 by Jake, CC BY-SA 3.0.

#let normal(y, mu) = calc.exp(-calc.pow(y - mu, 2) / 2) / (2 * calc.sqrt(calc.pi))

#cetz.canvas({
  import cetz.draw: *
  let elev = 28deg
  // Screen slope of the floor edges, used to lay labels along them.
  let tilt = calc.atan(calc.sin(elev))
  let (lo, hi, top) = (-4, 12, 0.3)

  // Canvas x = response y, canvas z = predictor x, canvas y = density.
  ortho(x: elev, y: -45deg, sorted: false, {
    scale(x: 0.35, y: 8, z: 0.7)
    set-style(stroke: 0.6pt + black)

    on-xz(rect((lo, 0), (hi, 8)))
    line((lo, 0, 0), (lo, top, 0), (hi, top, 0), (hi, top, 8), (hi, 0, 8))
    line((hi, 0, 0), (hi, top, 0))
    on-xz(line((0, 0), (8, 8), stroke: 1.2pt))

    for x in (1, 3, 5, 7) {
      on-xz(line((lo, x), (hi, x), stroke: (paint: gray, dash: "dashed")))
      on-xy(z: x, {
        let ys = range(61).map(i => x - 4 + i * 8 / 60)
        line(..ys.map(y => (y, normal(y, x))), close: true, stroke: none,
          fill: teal.darken(25%).transparentize(50%))
        line((x, 0), (x, normal(x, x)), stroke: (dash: "dashed"))
      })
    }

    on-xy(z: 6, {
      line((6, top), (6, 0), mark: (end: "stealth", fill: black))
      content((6, top), $upright(E)(Y) = X beta$, anchor: "south", padding: 0.1)
    })

    content((lo, 0, 4), [$x$: predictor], angle: -tilt, anchor: "north", padding: 0.15)
    content((4, 0, 8), [$y$: response], angle: tilt, anchor: "north", padding: 0.15)
    content((lo, top / 2, 0), [density], angle: 90deg, anchor: "south", padding: 0.15)
  })
})
