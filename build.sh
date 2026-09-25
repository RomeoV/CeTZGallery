#!/usr/bin/env bash
# Renders each figure to SVG, then builds docs/cetz-gallery.pdf and docs/index.html, which GitHub Pages serves.
set -euo pipefail
cd "$(dirname "$0")"
for f in figures/*.typ; do typst compile --format svg "$f" "${f%.typ}.svg"; done
typst compile gallery.typ docs/cetz-gallery.pdf
typst compile --features html --format html gallery.typ docs/index.html
