# Poisot Lab Manuscript Template

This template is a way to make writing academic papers using `pandoc` and
`markdown` simple.

To compile in draft mode, use `make`; to compile in preprint mode, use `make
TYPE=preprint`. That's it.

## Is it standard markdown?

Almost. There are two differences:

1. You *need to* use `!{figure.id}`, on a single line, to determine where the figure will appear
2. You *can* use `@id` in *CriticMarkup* to identify who wrote the comment

## What do you get?

- `critic.sh` -- a shell script that will transform *CriticMarkup* into the commands used by LaTeX `trackchanges.sty`
- `figures.py` -- a python script to deal with figures
- `Makefile` -- just type `make`, boom, PDF
- `plmt.tex` -- the LaTeX template
- `trackchanges.sty` -- the LaTeX style file for track changes (released under the *GPL v2.0*!)
- `ms.md` -- a template manuscript
- `ms.pdf` -- an example manuscript

## What do you need?

- `pandoc` (> 1.13, if not the arrays in `YAML` won't render)
- a (relatively well furnished) LaTeX distribution
- `perl`
- `python` and the `yaml` package
- `make`
- an idea for a manuscript

## Known bugs

- There may be issues when several annotated sentences are on the same line

## Plans

- something something tables?

## Unknown bugs

Oh boy.
