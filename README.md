# Poisot Lab Manuscript Template

This template is a way to make writing academic papers using `pandoc` and
`markdown` simple. Feel free to look at the pdf in the `output` folder to see
what it can do.

## Getting started

Edit the `ABSTRACT` file, change the authors names in `authors.yaml`, and the
basic document infos in `infos.yaml`.

To compile, use `make all`. If you have a `Rmd`, `Jmd` or a `md` file in your
directory (and it is called `manuscript`), then things should work.

Just type `make` to see a list of all possible commands:

~~~
all                 Make all the default outputs
clean               Remove the temporary file
dependencies        Install the required pandoc filters
diff                Create the pdf with track changes
draft               Create a pdf using the draft template
help                Show the help
.metadata.yaml      Compile the document metadata in a hidden file
odt                 Create a LibreOffice document
output/             Create the output directory to store the pdf and odt files
preprint            Create a pdf using the preprint template
~~~

If you want to dig in the structure, have a look at the `Makefile` -- the source
is commented quite a lot. The example document is the `manuscript.Rmd` file.

## Is it standard markdown?

Yes, with a few additional filters.

## What do you need?

- `pandoc`
- `LaTeX`
- `node` and `npm`
- GNU `make`
- an idea for a manuscript
- `knitr`, `Weave.jl` if you need to render these sort of things
- some pandoc filters (type `make dependencies` to install them)

## Roadmap

- URL should be more visible
- PDF metadata
