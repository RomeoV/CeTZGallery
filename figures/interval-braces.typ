#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// Margin of error; `fill` colors the z.
#let half(fill) = $#text(fill: fill, $z_(alpha\/2)$) dot sigma \/ sqrt(n)$

#cetz.canvas({
  import cetz.draw: *
  import cetz.decorations: flat-brace
  set-style(
    stroke: (paint: black, thickness: .5pt),
    content: (padding: .15),
    flat-brace: (amplitude: .2, content-offset: 0),
  )

  line((-3.3, 0), (3.3, 0), name: "ci", stroke: (thickness: 1pt), mark: (symbol: "|", width: .3))
  circle("ci.50%", radius: .07, fill: aqua)
  content("ci.50%", $overline(y)$, anchor: "north", padding: .25)
  content("ci.start", $overline(y) - #half(blue)$, anchor: "north")
  content("ci.end", $overline(y) + #half(orange)$, anchor: "north")

  flat-brace((rel: (0, .2), to: "ci.start"), (rel: (0, .2), to: "ci.50%"), name: "e")
  content("e.content", $e = #half(black)$, anchor: "south")
  flat-brace((rel: (0, 1.2), to: "ci.start"), (rel: (0, 1.2), to: "ci.end"), name: "2e")
  content("2e.content", $2e$, anchor: "south")
})
