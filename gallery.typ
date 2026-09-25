#let repo = "https://github.com/RomeoV/CeTZGallery"
#let site = "https://romeov.github.io/CeTZGallery/"
#let upstream = "https://github.com/walmes/Tikz"
// Pinned, so the links keep pointing at the files these figures were redrawn from.
#let upstream-file(name) = upstream + "/blob/3b873c32dc19938136c8215909d165a25622d0d7/src/" + name

#let figures = (
  ("sampling-plan", "Sampling-plan flowchart", "sampling-plan-2.pgf",
    [Relative placement from anchors; diamond decisions built from a text box's anchors; elbow branches with labels; two arrows meeting one box.]),
  ("reliability-blocks", "Series-parallel blocks", "circuitos_mistos1.pgf",
    [A data-driven loop; forks and joins with perpendicular coordinates; wires drawn behind the boxes with `on-layer`.]),
  ("system-io", "System with inputs and output", "reg_sistema.pgf",
    [Curved connectors ending at border anchors given as angles; a circle joined to a box; rotated captions.]),
  ("overlapping-groups", "Overlapping groups", "data-science-workflow.pgf",
    [Translucent frames around groups of nodes with `rect-around`; a cycle of bent arrows; placement by polar offsets.]),
  ("probability-tree", "Probability tree", "probtree_scheme.pgf",
    [`cetz.tree` growing to the right; custom node and edge callbacks; labels along the edges.]),
  ("polar-cycle", "Cycle on a triangle", "knowledge-cycle.pgf",
    [Polar coordinates; arrowheads in the middle of each edge; text rotated along edges; a Bézier curve with polar control points.]),
  ("density-tail", "Density with a shaded tail", "dist_t_quantil.pgf",
    [A plot in data units via `scale`; a sampled curve; a filled tail; tick loops; a curved callout.]),
  ("factorial-cube", "Factorial-design cube", "cubos-fatoriais-2a3.pgf",
    [An oblique 3D view from the canvas's `z` vector; a loop over vertices; framed circle markers joined by arrows.]),
  ("interval-braces", "Interval with braces", "confidence-interval-mean-components.pgf",
    [`flat-brace` with labels; interval end marks; colored parts of math labels.]),
  ("file-tree", "Directory tree", "file_tree.pgf",
    [A tree drawn from a flat data list; elbow connectors from each parent's south to each child's west.]),
)

#set document(title: "CeTZ Gallery")
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt)
#show heading: set text(fill: maroon)
#show link: set text(fill: blue)
#show raw: set text(font: ("Menlo", "DejaVu Sans Mono"), size: 8pt)
#show raw.where(block: true): it => context if target() == "html" { it } else {
  block(fill: luma(96%), inset: 8pt, radius: 3pt, width: 100%, it)
}

#context if target() == "html" { html.elem("style", read("assets/html.css")) }

#context if target() == "html" { html.elem("h1")[CeTZ Gallery] } else {
  align(center, text(28pt, weight: "bold", fill: maroon)[CeTZ Gallery])
}

Ten diagrams in idiomatic CeTZ 0.5.2, each chosen for a technique worth copying.

#link(site + "cetz-gallery.pdf")[View as PDF]. #link(site)[View as HTML]. #link(repo)[View source].

Every figure is a CeTZ redrawing of a TikZ figure from Walmes M. Zeviani's _Tikz Gallery_ [1].
Each entry links its original. The originals remain his work and are not copied into this project.
The redrawings translate the labels from Portuguese to English, use Typst's built-in colors, and differ in detail.

[1] Walmes M. Zeviani, _Tikz Gallery_. #link(upstream), #link("http://leg.ufpr.br/~walmes/Tikz/").

#outline(title: [Figures], depth: 1)

#for (name, title, original, techniques) in figures {
  pagebreak(weak: true)
  [#heading(title) #label(name)]
  [Redrawn from #link(upstream-file(original), raw(original)) in Walmes M. Zeviani's _Tikz Gallery_. #techniques]
  context if target() == "html" {
    html.elem("figure", image("figures/" + name + ".svg"))
  } else {
    align(center, image("figures/" + name + ".svg", width: 80%))
  }
  raw(read("figures/" + name + ".typ"), lang: "typ", block: true)
}
