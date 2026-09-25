#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)
// Based on https://tex.stackexchange.com/a/87956 by Claudio Fiandrino, CC BY-SA 3.0.

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)

  // A shape is its label "t" plus an outline drawn around the label's anchors.
  let node(body, outline, pad-x: 0.3) = pos => {
    content(pos, emph(body), name: "t", padding: (x: pad-x, y: 0.15))
    on-layer(-1, outline)
  }
  let chamfer = 0.3
  let rows = (
    (node([start/end], rect-around("t", radius: 0.2, fill: blue.lighten(75%))),
      [Start or end of a routine.]),
    (node([in/out], line((rel: (-chamfer, 0), to: "t.south-west"), "t.south-east",
      (rel: (chamfer, 0), to: "t.north-east"), "t.north-west", close: true,
      fill: yellow.lighten(60%))),
      [Data input or output.]),
    (node([processing], rect-around("t", fill: silver.lighten(30%))),
      [Calculations and general \ procedures.]),
    // Vertices at twice the label's half-size put the label's corners on the edges.
    (node([decision], line(..("north", "east", "south", "west").map(a => ("t", 200%, "t." + a)),
      close: true, fill: fuchsia.lighten(55%)), pad-x: 0.05),
      [Conditional control \ structure (decision).]),
    (node([loop], line((rel: (-chamfer, 0), to: "t.west"), "t.north-west", "t.north-east",
      (rel: (chamfer, 0), to: "t.east"), "t.south-east", "t.south-west", close: true,
      fill: green.lighten(65%))),
      [Repetition structure \ (loop).]),
    (pos => line((rel: (-1, -0.25), to: pos), (rel: (1, 0)), (rel: (0, 0.5)), (rel: (1, 0)),
      mark: (end: "stealth", fill: black)),
      [Flow of execution.]),
    (pos => circle(pos, radius: 0.15), [Connector.]),
    // The side bars sit outside the label box, as in TikZ's `predefined process`.
    (node([subroutine], {
      rect-around("t", padding: (x: 0.15))
      rect-around("t", fill: white)
    }), [Subroutine call.]),
  )

  // Shapes share a centre line; each row starts below the lower of the previous shape and text.
  let text-x = 2.1
  for (i, (shape, desc)) in rows.enumerate() {
    let top = if i == 0 { (0, 0) } else { ((0, 0), "|-", (rel: (0, -0.35), to: "row" + str(i - 1) + ".south")) }
    group(name: "row" + str(i), {
      group(name: "shape", anchor: "north", shape(top))
      content(((text-x, 0), "|-", "shape"), desc, anchor: "west")
    })
  }
})
