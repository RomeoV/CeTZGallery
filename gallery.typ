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
  (name: "venn-partition", title: "Venn partition", original: "diagrama_venn4.pgf", based-on: none,
    techniques: [`boolean(op: "intersection")` of a closed `merge-path` and a named ellipse, in place of clipping; loops for the partition curves and labels.]),
  (name: "floor-plan", title: "Floor plan", original: "floor-plan.pgf", based-on: none,
    techniques: [Walls from a list of `rel:` moves; `boolean(op: "difference")` hides the grid outside the room; a door swing `arc` from an anchor; furniture as rotated groups with a scoped style.]),
  (name: "flowchart-shapes", title: "Flowchart shapes", original: "fluxograms.pgf", based-on: (url: "https://tex.stackexchange.com/a/87956", author: "Claudio Fiandrino", license: "CC BY-SA 3.0"),
    techniques: [Shapes as small functions that draw their outline from the label's anchors (`rect-around`, parallelogram, hexagon, diamond); rows from a data list, stacked with `"|-"` coordinates.]),
  (name: "commit-graph", title: "Commit graph", original: "git_log.pgf", based-on: (url: "https://tex.stackexchange.com/a/262163", author: "ph0t0nix", license: "CC BY-SA 3.0"),
    techniques: [Layout from a data list of commits, lanes and parents; `bezier` edges that leave and enter vertically; messages and branch tags placed with perpendicular and relative coordinates.]),
  (name: "mind-map", title: "Mind map", original: "mindmapImovel.pgf", based-on: none,
    techniques: [Children at polar positions from a loop; tapered connectors as a `merge-path` of two `bezier` curves; colors from `color.mix`; `gradient.linear` fills behind the circles.]),
  (name: "timeline", title: "Timeline", original: "timeline_dataviz.pgf", based-on: none,
    techniques: [A data-driven callout helper placed by an angle anchor; leaders with `"|-"` coordinates; tag tabs relative to a box corner; a year-to-position mapping function.]),
  (name: "capillary-rise", title: "Capillary rise", original: "bouma.pgf", based-on: none,
    techniques: [A pseudo-3D tube from elliptical arcs; arrows at elliptical polar coordinates; `cetz.angle.angle` for the contact angle; `brace` for dimensions; curved callouts.]),
  (name: "threshold-crossing", title: "Threshold crossing", original: "anotacoes_intersecao.pgf", based-on: (url: "https://tex.stackexchange.com/a/130791", author: "Red", license: "CC BY-SA 3.0"),
    techniques: [`intersections` finds where the signal crosses the threshold, and a `"|-"` coordinate drops it to a computed tick; standalone `mark`s on data points; a legend boxed with `rect-around`.]),
  (name: "hatched-intervals", title: "Hatched intervals", original: "preenchimento.pgf", based-on: (url: "https://tex.stackexchange.com/a/29367", author: "Jake", license: "CC BY-SA 3.0"),
    techniques: [Typst `tiling` hatches with spacing and thickness as parameters; data units via `scale`; one loop for each series and its legend row.]),
  (name: "ternary-diagram", title: "Ternary diagram", original: "ternario.pgf", based-on: (url: "https://tex.stackexchange.com/a/277000", author: "Christian Feuersänger", license: "CC BY-SA 3.0"),
    techniques: [Barycentric coordinates; each triangle filled with an exact `gradient.linear` sampled from `color.map.viridis`; one loop for the grid, ticks and labels of all three sides; a matching color bar.]),
  (name: "regression-3d", title: "Regression densities in 3D", original: "reg_model_3d.pgf", based-on: (url: "https://tex.stackexchange.com/a/53795", author: "Jake", license: "CC BY-SA 3.0"),
    techniques: [An `ortho` view drawn back to front; `on-xz` for the floor and `on-xy` for density curves standing on it; labels rotated to the projected edges.]),
  (name: "bias-variance", title: "Bias and variance targets", original: "bias-variance.pgf", based-on: none,
    techniques: [Small multiples from one parameterized panel in nested loops; seeded pseudo-random hits from a tiny inline generator; rotated row headers.]),
)

// Figures are standalone documents; a page setting is not allowed inside a container, so drop it.
#let fig(name, width: 100%, height: auto) = layout(size => {
  let body = eval(read("figures/" + name + ".typ").replace("#set page(width: auto, height: auto, margin: 4mm)", ""), mode: "markup")
  let (width: w, height: h) = measure(body)
  let w-max = if type(width) == ratio { width * size.width } else { width }
  let k = calc.min(1, w-max / w, if height == auto { 1 } else { height / h })
  scale(k * 100%, reflow: true, body)
})

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

Diagrams in idiomatic CeTZ 0.5.2, each chosen for a technique worth copying.

#link(site + "cetz-gallery.pdf")[View as PDF]. #link(site)[View as HTML]. #link(repo)[View source].

Every figure is a CeTZ redrawing of a TikZ figure from Walmes M. Zeviani's _Tikz Gallery_ [1].
Each entry links its original.
The redrawings translate the labels from Portuguese to English, use Typst's built-in colors, and differ in detail.

[1] Walmes M. Zeviani, _Tikz Gallery_. #link(upstream), #link("http://leg.ufpr.br/~walmes/Tikz/").

#outline(title: [Figures], depth: 1)

#for (name, title, original, based-on, techniques) in figures {
  pagebreak(weak: true)
  [#heading(title) #label(name)]
  [Redrawn from #link(upstream-file(original), raw(original)) #link(upstream-file(original.replace(".pgf", ".png")))[(png)] in Walmes M. Zeviani's _Tikz Gallery_#if based-on != none [,
    which is based on #link(based-on.url)[an answer by #based-on.author] on TeX Stack Exchange (#based-on.license)].
    #techniques]
  context if target() == "html" { html.elem("figure", html.frame(fig(name))) } else { align(center, fig(name, width: 80%)) }
  raw(read("figures/" + name + ".typ"), lang: "typ", block: true)
}
