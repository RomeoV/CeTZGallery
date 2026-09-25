#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// Series-parallel reliability block diagram: each stage holds redundant
// components in parallel, and the stages are connected in series.
#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)

  let stages = ((0.95, 3), (0.7, 2), (0.7, 1)) // (reliability, count)
  let (dx, dy, w, h) = (1.7, 0.9, 1, 0.45)

  let prev = (rel: (-0.5, 0), to: "s0.west") // resolved when drawn, after "s0" exists
  for (i, (p, n)) in stages.enumerate() {
    let s = "s" + str(i)
    // The x-padding puts the group's west/east anchors on the fork and join buses.
    group(name: s, padding: (x: 0.2), {
      for k in range(n) {
        rect((i * dx, ((n - 1) / 2 - k) * dy), (rel: (w, h)), anchor: "center",
          fill: teal.lighten(60%), name: str(k))
        content(str(k), [#p])
      }
    })
    // Wires pass straight through the boxes, so draw them behind.
    on-layer(-1, {
      let (fork, join) = (s + ".west", s + ".east")
      line(prev, fork)
      for k in range(n) {
        let b = s + "." + str(k)
        line(fork, (fork, "|-", b), (join, "|-", b), join)
      }
    })
    prev = s + ".east"
  }
  line(prev, (rel: (0.5, 0)), mark: (end: "stealth", fill: black))
})
