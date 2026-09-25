#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)
// Based on https://tex.stackexchange.com/a/262163 by ph0t0nix, CC BY-SA 3.0.

// Newest first, as in `git log --graph`: (hash, lane, parents, message, branch tag).
#let commits = (
  ("ef1eae1", 0, ("6ea97fa",), "Update settings for the new feature", "sub-feature"),
  ("4f669eb", 1, ("6ea97fa",), "Add README with basic documentation", "feature-a"),
  ("9216cb2", 1, ("167af36",), "Print a start message", "main"),
  ("77c49c1", 2, ("167af36",), "Add a helper script", "feature-b"),
  ("167af36", 1, ("a2a2593",), "Print date and time at the end of the run", none),
  ("a2a2593", 1, ("9f51c0d", "6ea97fa"), "Merge branch 'feature-a'", none),
  ("6ea97fa", 0, ("2e10426",), "Extend the notes on the feature", none),
  ("9f51c0d", 1, ("2e10426",), "Print a message when the script ends", none),
  ("2e10426", 0, ("91f1fef",), "Add a line of text to notes.txt", none),
  ("91f1fef", 0, ("1ddccf6",), "Convert run.txt to a shell script", none),
  ("1ddccf6", 0, ("2f06323",), "Add a file with several lines", none),
  ("2f06323", 0, (), "Initial commit", none),
)
#let lanes = (green.darken(20%), blue, red)

#cetz.canvas({
  import cetz.draw: *

  for (row, (id, lane, _, msg, tag)) in commits.enumerate() {
    let hue = lanes.at(lane)
    circle((lane * 0.5, -row * 0.5), radius: 0.07, fill: hue, stroke: hue, name: id)
    // Messages share a column right of the widest lane, so no edge runs through them.
    content(((1.3, 0), "|-", id), raw(id + ": " + msg), anchor: "west", name: id + "-msg")
    if tag != none {
      content((rel: (0.25, 0), to: id + "-msg.east"), anchor: "west",
        box(raw(tag), stroke: 0.6pt + hue, radius: 3pt, inset: 2pt))
    }
  }

  // Each edge leaves the parent and enters the child vertically, in the child's lane colour.
  on-layer(-1, for (id, lane, parents, ..) in commits {
    for parent in parents {
      let mid = (parent, 50%, id)
      bezier(parent, id, (parent, "|-", mid), (id, "|-", mid), stroke: 0.8pt + lanes.at(lane))
    }
  })
})
