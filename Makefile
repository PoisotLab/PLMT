SOURCE=ms.md
OUTPUT=ms.pdf
#BIB=/path/to/wherever.bib
#CSL=/path/to/wherever.csl
PFLAGS= --template plmt.tex #--bibliography=$(BIB) --csl=$(CSL)

PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(SOURCE)
	# Critic markup
	perl critic.pl $< > marked_$(SOURCE)
	# Compile
	pandoc marked_$(SOURCE) -o $@ $(PFLAGS)
	# Clean
	rm marked_$(SOURCE)
