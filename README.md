# Poisot Lab Manuscript Template

This template is a way to make writing academic papers using `pandoc` and
`markdown` simple.

## What do you get?

- `critic.pl` -- a perl script that will transform *CriticMarkup* into the commands used by LaTeX `trackchanges.sty`
- `Makefile` -- just type `make`, boom, PDF
- `plmt.tex` -- the LaTeX template
- `trackchanges.sty` -- the LaTeX style file for track changes (released under the *GPL v2.0*!)
- `ms.md` -- a template manuscript
- `ms.pdf` -- an example manuscript

## What do you need?

- `pandoc` (> 1.13, if not the arrays in `YAML` won't render)
- a (relatively well furnished) LaTeX distribution
- `perl`
- an idea for a manuscript

## Known bugs

- `critic.pl` chokes on multi-line CriticMarks

## Plans

- add a `preprint` mode to make *good looking* preprints
- something something tables?

## Unknown bugs

Oh boy.
