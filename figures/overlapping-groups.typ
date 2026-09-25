#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  set-style(
    stroke: 0.6pt + black,
    mark: (end: "stealth", fill: black, scale: 0.8),
    content: (padding: 0.08),
  )

  // Bare element names make `line` stop at both borders.
  let step(from, name, offset) = {
    content((rel: offset, to: from), name, name: name)
    line(from, name)
  }
  // Cubic curve leaving `a` and entering `b` at `angle` to the chord, like TikZ `bend left`.
  let bend(a, b, angle) = bezier(a, b, (a, 40%, angle, b), (b, 40%, -angle, a))

  content((0, 0), "Formulate", name: "Formulate")
  let prev = "Formulate"
  for (name, offset) in (
    ("Design", (0deg, 2)), ("Collect", (-45deg, 1.25)), ("Store", (-45deg, 1.25)),
    ("Import", (-45deg, 1.25)), ("Tidy", (45deg, 1.25)), ("Transform", (45deg, 1.25)),
  ) {
    step(prev, name, offset)
    prev = name
  }

  content((rel: (2.3, 0.8), to: "Transform"), "Visualize", name: "Visualize")
  content((rel: (2.3, -0.8), to: "Transform"), "Model", name: "Model")
  bend((name: "Transform", anchor: 45deg), "Visualize.west", 30deg)
  bend("Visualize.south", "Model.north", 30deg)
  bend("Model.west", (name: "Transform", anchor: -45deg), 30deg)

  step("Model", "Understand", (0deg, 2))
  step("Understand", "Act", (-90deg, 1.25))

  on-layer(-1, {
    for (members, hue, caption) in (
      (("Design", "Import"), blue, [Computer scientist]),
      (("Import", "Visualize"), red, [Statistician]),
    ) {
      rect-around(..members, padding: 0.15, radius: 0.1, name: "group",
        stroke: hue, fill: hue.transparentize(85%))
      content("group.south", text(hue, caption), anchor: "north")
    }
    rect-around("Formulate", "Import", "Understand", "Act", padding: 0.6, radius: 0.15,
      stroke: gray, name: "all")
    content("all.north", [Data scientist], anchor: "south")
  })
})
