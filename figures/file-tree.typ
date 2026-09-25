#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// (depth, name) in `tree` order; an entry is a directory if the next one is deeper.
#let entries = (
  (0, "src"),
  (1, "asf"), (2, "avr32"), (3, "drivers"), (4, "canif"),
  (5, "canif.h"), (5, "canif.c"),
  (1, "net"), (2, "can"),
  ..("can.h", "can_mob.h", "can_mob.c", "can_port.h", "can_port.c", "can_trcv.h", "can_trcv.c")
    .map(file => (3, file)),
  (1, "..."),
)

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: (paint: black, thickness: .6pt))

  let y = 0
  let prev-depth = 0
  for (i, (depth, name)) in entries.enumerate() {
    let dir = entries.at(i + 1, default: (0,)).at(0) > depth
    y -= if depth == prev-depth { .4 } else { .6 }
    prev-depth = depth

    // Reused names: "d2" is the latest depth-2 node, i.e. the parent of each new depth-3 node.
    let node = "d" + str(depth)
    content((depth * .85, y), name: node, anchor: "west", box(
      raw(name), inset: 2.5pt, radius: 2pt,
      fill: if depth == 0 { eastern.lighten(50%) } else if dir { eastern.lighten(85%) },
      stroke: if dir { blue + .8pt },
    ))
    if depth > 0 {
      let parent = "d" + str(depth - 1) + ".south"
      line(parent, (parent, "|-", node + ".west"), node + ".west")
    }
  }
})
