#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas({
  import cetz.draw: *
  set-style(
    stroke: .5pt + black,
    mark: (end: "stealth", fill: black),
    content: (padding: .12),
  )

  let draw-node(n) = if n.depth < 2 {
    let bag = box.with(fill: eastern.lighten(75%), radius: 4pt, inset: 7pt, width: 4.2em)
    content((0, 0), padding: 0, bag(align(center, $Pr(#n.content)$)))
  } else {
    circle((0, 0), radius: .05, fill: black, stroke: none)
  }

  let draw-edge(parent, child) = {
    let (a, b) = (parent.content, child.content)
    line(parent.group-name, child.group-name, name: "e")
    content("e.mid", $Pr(#b|#a)$, angle: "e.end", anchor: "north")
    // Only the edge callback sees both events, so it also labels the leaf.
    if child.depth == 2 {
      content(child.group-name + ".east", $Pr(#b inter #a)$, anchor: "west")
    }
  }

  // With direction "right", children are listed bottom to top.
  cetz.tree.tree(
    ($Omega$, ($A^c$, $B^c$, $B$), ($A$, $B^c$, $B$)),
    direction: "right", grow: 3, spread: 1.6,
    draw-node: draw-node, draw-edge: draw-edge,
  )
})
