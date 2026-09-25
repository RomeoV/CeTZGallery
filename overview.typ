// A contact sheet of all figures with their titles, in gallery order.
#import "gallery.typ": figures, fig
#set page(width: 32cm, height: auto, margin: 8mm)
#set text(font: ("Helvetica Neue", "Arial"), size: 11pt)
#grid(columns: 4, gutter: 8mm, ..figures.map(f => block(breakable: false, width: 100%, {
  align(center + horizon, box(height: 5.5cm, fig(f.name, height: 5.5cm)))
  v(2mm)
  align(center)[*#f.title* \ #text(9pt, raw(f.name + ".typ"))]
})))
