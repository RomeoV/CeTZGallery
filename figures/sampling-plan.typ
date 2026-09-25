#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

// Double-sampling acceptance plan: Ac = acceptance number, Re = rejection number.
#let Ac = $A c$
#let Re = $R e$

#cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)

  // A Typst box gives rounded corners while the anchors stay on its bounding box.
  let step(pos, name, body, fill: silver.lighten(60%), anchor: "north") = content(pos, name: name,
    anchor: anchor, box(body, fill: fill, stroke: 0.6pt + black, radius: 3pt, inset: 5pt))
  // A diamond whose edge midpoints touch the corners of the text box.
  let decision(pos, name, body) = group(name: name, anchor: "north", {
    content(pos, box(width: 4.5em, align(center, par(leading: 0.35em, body))), name: "text")
    on-layer(-1, line(..("north", "east", "south", "west").map(a => ("text", 200%, "text." + a)),
      close: true, fill: gray.lighten(60%)))
  })
  let arrow = line.with(stroke: 0.9pt + black, mark: (end: "stealth", fill: black))
  let branch(from, to, label) = {
    let corner = (from, "-|", to)
    arrow(from, corner, to)
    content((from, 50%, corner), label, anchor: "south", padding: 0.1)
  }

  let gap = 0.35
  step((0, 0), "plan", [Define sampling plan ($n_1$, $n_2$, $Ac_1$, $Ac_2$, $Re_1$)])
  step((rel: (0, -gap), to: "plan.south"), "ins1", [Inspect first sample $n_1$])
  decision((rel: (0, -gap), to: "ins1.south"), "d1", [Compare $d_1$, $Ac_1$ and $Re_1$])
  step((rel: (0, -2.5 * gap), to: "d1.south"), "ins2", [Inspect second sample $n_2$])
  decision((rel: (0, -gap), to: "ins2.south"), "d2", [Compare $d_1 + d_2$ and $Ac_2$])
  step((rel: (2 * gap, 0), to: "ins2.east"), "accept", [Accept lot],
    fill: eastern.lighten(60%), anchor: "west")
  step((rel: (-2 * gap, 0), to: "ins2.west"), "reject", [Reject lot],
    fill: orange.lighten(60%), anchor: "east")

  arrow("plan", "ins1")
  arrow("ins1", "d1")
  arrow("d1", "ins2")
  content(("d1.south", 50%, "ins2.north"), $Ac_1 < d_1 < Re_1$, anchor: "west", padding: 0.1)
  arrow("ins2", "d2")
  branch("d1.east", "accept.north", $d_1 <= Ac_1$)
  branch("d1.west", "reject.north", $d_1 > Re_1$)
  branch("d2.east", "accept.south", $d_1 + d_2 <= Ac_2$)
  branch("d2.west", "reject.south", $d_1 + d_2 > Ac_2$)
})
