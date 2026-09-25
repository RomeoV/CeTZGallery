#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)
// Based on https://tex.stackexchange.com/a/277000 by Christian Feuersänger, CC BY-SA 3.0.

#let cmap = gradient.linear(..color.map.viridis, angle: -90deg)
#let keys = ("x", "y", "z")
#let corners = range(3).map(i => 90deg + i * 120deg).map(a => (3 * calc.cos(a), 3 * calc.sin(a)))

#cetz.canvas({
  import cetz.draw: *
  import cetz: vector
  set-style(stroke: .6pt + black, content: (padding: 3pt))
  for (k, c) in keys.zip(corners) { anchor(k, c) }

  // Gouraud-shade a triangle given as rows (x, y, z, value) of the source table.
  let patch(..rows) = {
    let rows = rows.pos()
    let pts = rows.map(r => corners.zip(r).map(((c, w)) => vector.scale(c, w)).reduce(vector.add))
    let vs = rows.map(r => r.last())
    // Gradient of the linear interpolant, from the sides rotated a quarter turn.
    let normals = range(3).map(i => vector.sub(pts.at(calc.rem(i + 1, 3)), pts.at(calc.rem(i + 2, 3))))
      .map(((dx, dy)) => (dy, -dx))
    let det = range(3).map(i => pts.at(i).at(0) * normals.at(i).at(0)).sum()
    let g = range(3).map(i => vector.scale(normals.at(i), vs.at(i) / det)).reduce(vector.add)
    // Typst turns gradients clockwise and stretches them between the extreme bounding-box corners.
    let (xs, ys) = array.zip(..pts)
    let vc = for x in (calc.min(..xs), calc.max(..xs)) { for y in (calc.min(..ys), calc.max(..ys)) {
      (vs.first() + vector.dot(g, vector.sub((x, y), pts.first())),)
    } }
    let (lo, hi, va, vb) = (calc.min(..vs), calc.max(..vs), calc.min(..vc), calc.max(..vc))
    let stops = range(11).map(k => lo + (hi - lo) * k / 10)
      .map(v => (cmap.sample(v * 1%), (v - va) / (vb - va) * 100%))
    let paint = gradient.linear((stops.first().at(0), 0%), ..stops, (stops.last().at(0), 100%),
      angle: -calc.atan2(..g))
    line(..pts, close: true, fill: paint, stroke: .5pt + paint)
  }
  patch((0, 0, 1, 100), (1, 0, 0, 0), (.5, .5, 0, 0))
  patch((.5, .5, 0, 0), (0, 1, 0, 20), (0, 0, 1, 100))

  // Axis k is read along the side where the next key is zero; its lines of constant k
  // run from that side towards the side where the key after next is zero.
  for (i, k) in keys.enumerate() {
    let (a, b) = (keys.at(calc.rem(i + 1, 3)), keys.at(calc.rem(i + 2, 3)))
    let dir = i * 120deg
    for v in range(0, 101, step: 20) {
      let t = v / 100
      let edge = (bary: ((k): t, (b): 1 - t))
      if 0 < v and v < 100 { line((bary: ((k): t, (a): 1 - t)), edge, stroke: silver) }
      line(edge, (rel: (dir, .15)), name: "tick")
      content("tick.end", $#v$, anchor: ("west", "south-east", "north").at(i))
    }
    content((rel: (dir + 30deg, .8), to: (bary: ((k): 1, (b): 1))), $italic(#k)$)
  }
  line(..keys, close: true)

  rect((rel: (1, 0), to: "z"), ((rel: (1.4, 0), to: "z"), "|-", "x"), fill: cmap,
    name: "bar")
  for v in range(0, 101, step: 20) {
    let p = ("bar.south-east", v * 1%, "bar.north-east")
    line(p, (rel: (-.1, 0)))
    content(p, $#v$, anchor: "west")
  }
})
