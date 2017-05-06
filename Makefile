# PLMT Makefile -- a lot of the action happens here!

# By default, make sure that the FILE variable is correct, then just type `make
# all`. This makefile has built-in help, so you can type `make` (or `make help`)
# to see what is available

# The FILE variable is the name of the md, Rmd, or Jmd file with the manuscript.
FILE=manuscript

# SOURCE is the name of the file that will actually be processed. Better leave
# this alone.
SOURCE=$(FILE).md

# BIB is the path to the JSON (or any other format recognized by
# pandoc-citeproc) file with the references.
BIB=references.json

# CSL is the path to the file with the CSL style to render the references.
CSL=.plmt/plab.csl

# MARKED is the path with the intermedidate steps applied (mostly, changing the
# criticmarkup marks into LaTeX markup). Better leave this alone too.
MARKED= ./.plmt/processed.md

# PFLAGS is the list of pandoc filters and options required to make the
# documents. You can add some, but it is probably wise not to remove any.
PFLAGS= --filter pandoc-fignos --filter pandoc-tablenos --filter pandoc-eqnos --filter pandoc-citeproc --listings --bibliography $(BIB) --csl $(CSL)

# TAG is the version of the git tag or commit against which the track-changed
# pdf should be built. By default, it is the latest commit (so you can see your
# work in progress). We advise to tag the most important drafts, submitted, and
# revised versions.
TAG!= git log --oneline | cut -d' ' -f1 | head -n 1

# AS is a variable to decided how the track-changed pdf will be rendered:
# preprint or draft.
AS=preprint

# This is makefile jargon, don't sweat it.
.PHONY: all output/ help dependencies

# By default, we wish only to help!
.DEFAULT_GOAL := help

help: #> Show the help
	@grep -E '^[$$()a-zA-Z_-.]+:.*?#> .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?#> "}; {printf "\033[36m%-19s\033[0m %s\n", $$1, $$2}'

output/: #> Create the output directory to store the pdf and odt files
	mkdir -p output

# This rule will, by default, make the draft, the preprint, the raw latex fil,
# and the odt document.
all: draft preprint odt latex #> Make all the default outputs

# This rule will create a document with the changes marked. The behavior of this
# command is affected by the `TAG` variable (which version to compare to), and
# the AS variable (the type of document to render).
diff: output/diff_$(FILE)_$(TAG)_$(AS).pdf #> Create the pdf with track changes

clean: #> Remove the temporary file
	rm $(MARKED)

# .metadata.yaml is one of the most important file, since it stores the authors,
# affiliations, and the abstract (among other things). This file should never be
# updated manually. Instead, look at authors.json, infos.json, and ABSTRACT.
.metadata.yaml: infos.yaml authors.yaml ABSTRACT #> Compile the document metadata in a hidden file
	node .plmt/metadata.js
	sed -i '1s/^/---\n/' $@
	echo "..." >> $@

# This rule will compile the Rmd file to the md file IF there is a Rmd file with
# the same name. If not, it will do nothing.
rmd2md: $(wildcard $(FILE).Rmd) #> Convert the Rmd file to the md file using knitr
	@$(if $(wildcard $(FILE).Rmd),Rscript -e "library(knitr); knit(input='$<', output='$(SOURCE)')",echo "No Rmd file found")

# This rule will compile the Jmd file to the md file IF there is a Jmd file with
# the same name. If not, it will do nothing.
jmd2md: $(wildcard $(FILE).Jmd) #> Convert the Jmd file to the md file using Weave.jl
	@$(if $(wildcard $(FILE).Jmd),julia -e 'using Weave; weave("$<", doctype="pandoc")',echo "No Jmd file found")

# If there is no Jmd or Rmd file, this rule with do nothing. If there is either
# of these files, it will compile them to md.
$(SOURCE): jmd2md rmd2md

# This rule will create the temporary file which is actually used by pandoc,
# based on the md file and the metadata. This is mostly about handling the
# critic markup.
$(MARKED): $(SOURCE) .metadata.yaml
	@node .plmt/critic.js $< $@

# Output documents

# These are the three core rules -- better to leave them alone.

preprint: output/$(FILE)_preprint.pdf #> Create a pdf using the preprint template

draft: output/$(FILE)_draft.pdf #> Create a pdf using the draft template

latex: output/$(FILE).tex #> Create a LaTeX standalone document for publishers

odt: output/$(FILE).odt #> Create a LibreOffice document

# Additional rules go here. By default, they are commented, but removing the #
# in front will activate them.

#plos: output/$(FILE)_plos.pdf #> Create a pdf using the PLOS template for submission

# These are the actual rules to build the documents -- they will go into the
# output/ folder.
output/$(FILE)_preprint.pdf: $(MARKED)
	pandoc $(MARKED) -o $@ $(PFLAGS) --template ./.plmt/templates/preprint.template .metadata.yaml

output/$(FILE)_draft.pdf: $(MARKED)
	pandoc $(MARKED) -o $@ $(PFLAGS) --template ./.plmt/templates/draft.template .metadata.yaml

output/$(FILE).tex: $(MARKED)
	pandoc $(MARKED) -o $@ $(PFLAGS) --template ./.plmt/templates/raw.template .metadata.yaml

output/$(FILE).odt: $(MARKED)
	pandoc $(MARKED) -o $@ $(PFLAGS) --template ./.plmt/templates/opendocument.template .metadata.yaml

# Rules for the other documents go here

$(FILE)_plos.pdf: $(MARKED)
	pandoc $(MARKED) -o $@ $(PFLAGS) --template ./.plmt/templates/plos.template .metadata.yaml

# These are the rules to make the track-changed pdf

# This rule will checkout the source file at the specified TAG, and call it
# `revised.md`.
revised.md: $(SOURCE)
	cp $(SOURCE) temp.md
	git checkout $(TAG) $(SOURCE)
	mv $(SOURCE) $@
	mv temp.md $(SOURCE)

# This is the rule to create the track changed pdf. The filename will have the
# TAG in it.
output/diff_$(FILE)_$(TAG)_$(AS).pdf: revised.md
	git diff --no-index --word-diff -U2000 $< $(SOURCE) > out.md
	sed -i "s/\[-/\{--/" out.md
	sed -i "s/-\]/--\}/" out.md
	sed -i "s/\{+/\{++/" out.md
	sed -i "s/+\}/++\}/" out.md
	pandoc $< -o old.tex $(PFLAGS) --template ./.plmt/templates/$(AS).template .metadata.yaml
	pandoc $(MARKED) -o new.tex $(PFLAGS) --template ./.plmt/templates/$(AS).template .metadata.yaml
	latexdiff old.tex new.tex > diff.tex
	latexmk -pdf diff.tex
	latexmk -c
	pdf2ps diff.pdf diff.ps
	ps2pdf13 diff.ps diff.pdf
	rm diff.ps
	rm {old,new,diff}.tex
	mv diff.pdf $@

# This installs the python dependencies. Might have to be run with `sudo make
# dependencies` depending on your system.
dependencies: #> Install the required pandoc filters
	pip install pandoc-fignos pandoc-eqnos pandoc-tablenos
