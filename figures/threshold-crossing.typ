#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// Based on https://tex.stackexchange.com/a/130791 by Red, CC BY-SA 3.0.

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: .5pt + black, content: (padding: 4pt))
  // Data coordinates (sample, amplitude); text, strokes and marks keep their size.
  scale(x: .11, y: 2.8)

  let (x0, x1, y0, y1) = (1, 64, -.2, 1.6)
  let signal(x) = calc.exp(-calc.log(2) / 16 * calc.pow(x - 32, 2))
  let samples = range(32).map(i => x0 + (x1 - x0) * i / 31).map(x => (x, signal(x)))

  for x in range(10, 61, step: 10) {
    line((x, y0), (x, y1), stroke: (paint: gray, dash: "dashed"))
    content((x, y0), $#x$, anchor: "north")
  }
  for y in (0, .5, 1, 1.5) {
    line((x0, y), (x1, y), stroke: (paint: gray, dash: "dashed"))
    content((x0, y), $#y$, anchor: "east")
  }
  line((x0, y1), (x0, y0), (x1, y0), mark: (start: "stealth", end: "stealth", fill: black))
  content((x1, y0), emph[sample number], anchor: "north-west")

  line((x0, .5), (x1, .5), stroke: .8pt + red, name: "threshold")
  let plus(p) = mark(p, 0deg, "+", stroke: blue, length: .16, width: .16)
  line(..samples, stroke: .8pt + blue, name: "signal")
  samples.map(plus).join()

  // "cross.0" is the rising crossing, the first one along the signal.
  intersections("cross", "signal", "threshold")
  line("cross.0", ("cross.0", "|-", (0, y0)), stroke: (dash: "dashed"), name: "drop")
  content((rel: (0, -.12), to: "drop.end"), $t_"step"$, anchor: "north")

  group(name: "legend", {
    set-origin((x1 + 3, y1))
    for (i, (hue, label)) in ((blue, [Sampled signal]), (red, [Threshold])).enumerate() {
      line((0, -.15 * i - .1), (rel: (6, 0)), stroke: .8pt + hue, name: "key")
      if i == 0 { plus("key.50%") }
      content("key.end", label, anchor: "west")
    }
  })
  rect-around("legend")
})
