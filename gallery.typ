#let repo = "https://github.com/RomeoV/CeTZGallery"
#let site = "https://romeov.github.io/CeTZGallery/"
#let upstream = "https://github.com/walmes/Tikz"
// Pinned, so the links keep pointing at the files these figures were redrawn from.
#let upstream-file(name) = upstream + "/blob/3b873c32dc19938136c8215909d165a25622d0d7/src/" + name

// based-on: none, or (url:, author:, license:) for figures derived from a Stack Exchange answer.
#let figures = (
  (name: "sampling-plan", title: "Sampling-plan flowchart", original: "sampling-plan-2.pgf", based-on: none,
    techniques: [Relative placement from anchors; diamond decisions built from a text box's anchors; elbow branches with labels; two arrows meeting one box.]),
  (name: "reliability-blocks", title: "Series-parallel blocks", original: "circuitos_mistos1.pgf", based-on: none,
    techniques: [A data-driven loop; forks and joins with perpendicular coordinates; wires drawn behind the boxes with `on-layer`.]),
  (name: "system-io", title: "System with inputs and output", original: "reg_sistema.pgf", based-on: none,
    techniques: [Curved connectors ending at border anchors given as angles; a circle joined to a box; rotated captions.]),
  (name: "overlapping-groups", title: "Overlapping groups", original: "data-science-workflow.pgf", based-on: none,
    techniques: [Translucent frames around groups of nodes with `rect-around`; a cycle of bent arrows; placement by polar offsets.]),
  (name: "probability-tree", title: "Probability tree", original: "probtree_scheme.pgf", based-on: none,
    techniques: [`cetz.tree` growing to the right; custom node and edge callbacks; labels along the edges.]),
  (name: "polar-cycle", title: "Cycle on a triangle", original: "knowledge-cycle.pgf", based-on: none,
    techniques: [Polar coordinates; arrowheads in the middle of each edge; text rotated along edges; a Bézier curve with polar control points.]),
  (name: "density-tail", title: "Density with a shaded tail", original: "dist_t_quantil.pgf", based-on: none,
    techniques: [A plot in data units via `scale`; a sampled curve; a filled tail; tick loops; a curved callout.]),
  (name: "factorial-cube", title: "Factorial-design cube", original: "cubos-fatoriais-2a3.pgf", based-on: none,
    techniques: [An oblique 3D view from the canvas's `z` vector; a loop over vertices; framed circle markers joined by arrows.]),
  (name: "interval-braces", title: "Interval with braces", original: "confidence-interval-mean-components.pgf", based-on: none,
    techniques: [`flat-brace` with labels; interval end marks; colored parts of math labels.]),
  (name: "file-tree", title: "Directory tree", original: "file_tree.pgf", based-on: none,
    techniques: [A tree drawn from a flat data list; elbow connectors from each parent's south to each child's west.]),
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

#for (name, title, original, based-on, techniques) in figures {
  pagebreak(weak: true)
  [#heading(title) #label(name)]
  [Redrawn from #link(upstream-file(original), raw(original)) #link(upstream-file(original.replace(".pgf", ".png")))[(png)] in Walmes M. Zeviani's _Tikz Gallery_#if based-on != none [,
    which is based on #link(based-on.url)[an answer by #based-on.author] on TeX Stack Exchange (#based-on.license)].
    #techniques]
  context if target() == "html" {
    html.elem("figure", image("figures/" + name + ".svg"))
  } else {
    align(center, image("figures/" + name + ".svg", width: 80%))
  }
  raw(read("figures/" + name + ".typ"), lang: "typ", block: true)
}
