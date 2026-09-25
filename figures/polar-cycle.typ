#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#let note(title, sub) = align(center)[#title \ #text(size: 7pt, sub)]

#cetz.canvas({
  import cetz.draw: *
  set-style(
    stroke: .6pt + black,
    // Mid-path arrowhead; shorten-to: none keeps CeTZ from cutting the path at the mark.
    mark: (end: "stealth", pos: 50%, anchor: "center", shorten-to: none,
      scale: 1.4, fill: red, stroke: red),
    content: (padding: .2),
  )

  anchor("nature", (90deg, 3))
  anchor("model", (210deg, 3))
  anchor("data", (330deg, 3))
  content("nature", text(12pt, align(center)[*Nature* \ (phenomenon)]), anchor: "south")
  content("model", text(12pt)[*Model*], anchor: "east")
  content("data", text(12pt)[*Data*], anchor: "west")

  let edge(a, b, label) = {
    line(a, b, name: "e")
    content("e.mid", label, angle: "e.end", anchor: "south")
  }
  edge("model", "nature", note[Theory][Explanation of nature])
  edge("nature", "data", note[Observation][Experiment / sampling])
  line("data", "model", name: "inference")
  content("inference.mid", [Statistical inference], anchor: "north")

  bezier("data", "nature", (rel: (60deg, 2), to: "data"), (rel: (0deg, 2), to: "nature"),
    name: "arc", stroke: gray, mark: (fill: red, stroke: red))
  content("arc.mid", angle: -60deg, anchor: "south",
    text(fill: gray, align(center)[Descriptive \ statistics]))
})
