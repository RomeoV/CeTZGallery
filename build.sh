#!/usr/bin/env bash
# Builds docs/cetz-gallery.pdf, docs/index.html, the contact sheet docs/overview.png and a PNG per figure,
# which GitHub Pages serves.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs/figures
for f in figures/*.typ; do typst compile --format png --ppi 150 "$f" "docs/${f%.typ}.png"; done
typst compile --format png --ppi 100 overview.typ docs/overview.png
typst compile gallery.typ docs/cetz-gallery.pdf
typst compile --features html --format html gallery.typ docs/index.html
