#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 4mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: black)

#cetz.canvas(length: 1.2cm, {
  import cetz.draw: *
  set-style(stroke: 0.6pt + black)

  // One unit per decade from 1850; the dashed stub stands in for the years back to 1786.
  let x(year) = calc.max((year - 1850) / 10, -1.1)
  line((-1.1, 0), (0, 0), stroke: (dash: "dashed"))
  line((0, 0), (17.2, 0), mark: (end: "stealth", fill: black))
  for i in range(17) { line((i, -0.1), (i, 0.1)) }
  let rule = red.darken(10%)
  line((14, 0), (15, 0), name: "scale", stroke: rule + 0.9pt,
    mark: (symbol: ("|", ">"), fill: rule))
  content("scale.mid", text(8pt, rule)[10 years], anchor: "south", padding: 0.12)

  // The box's border point at angle `at` lies at `offset` from the event.
  let callout(year, offset, at, title, body) = {
    let p = (x(year), 0)
    let a = (name: "box", anchor: at)
    content((rel: offset, to: p), name: "box", anchor: at,
      box(fill: white, stroke: 0.6pt, radius: 2pt, inset: (x: 4pt, top: 13pt, bottom: 5pt), body))
    content((rel: (0.15, 0.1), to: "box.north-west"), anchor: "west",
      box(fill: orange, radius: 2pt, inset: 3pt, title))
    on-layer(-1, line(p, (p, "|-", a), a))
    circle(p, radius: 2pt, fill: black)
  }

  for e in (
    (1786, (0, 1.9), -170deg, [1786 - William Playfair],
      [Line, bar and pie charts.]),
    (1854, (0, -2.5), 140deg, [1854 - John Snow],
      [Mapping that found \ the source of cholera.]),
    (1858, (0, 0.5), -168.5deg, [1858 - Florence Nightingale],
      [“Coxcomb” diagrams of the British army.]),
    (1861, (0, -0.8), 158deg, [1861 - Charles Minard],
      [Napoleon's army \ marches on Russia.]),
    (1914, (-0.2, 3.8), 0deg, [1914 - Willard Brinton],
      [_Graphic methods for presenting facts_ \ Visualization for business.]),
    (1952, (0, -0.8), 30deg, [1952 - Mary Eleanor Spear],
      [_Charting statistics_ \ Good practice in the \ US government.]),
    (1967, (0, 1.0), -16deg, [1967 - Jacques Bertin],
      [_Sémiologie graphique_ \ Theory of vis. and 7 visual variables.]),
    (1970, (0, -3.0), 24deg, [1970s - John Tukey],
      [Vis. with computers: \ exploratory and confirmatory.]),
    (1983, (0, 3.7), -20deg, [1983 - Edward Tufte],
      [_The visual display of quantitative information_ \ Statistical rigour, clarity, design.]),
    (1984, (0, -5.2), 90deg, [1984 - W. Cleveland & R. McGill],
      [Measuring graphical perception and effective vis.]),
    (1986, (0.2, 2.8), 180deg, [1986 - Jock Mackinlay],
      [Thesis on J. Bertin for the digital age.]),
    (1999, (0, -3.0), 150deg, [1999 - Leland Wilkinson],
      [_The grammar of graphics_ \ A concise grammar for \ graphical components.]),
    (2010, (0, 0.7), -90deg, [2010 - Ronald Rensink],
      [Perception · Weber's law \ Graphical effectiveness.]),
    (2018, (0, -0.8), 150deg, [Today],
      [Tools for building vis. \ Interactive and real-time vis. \ Dashboards]),
  ) { callout(..e) }
})
