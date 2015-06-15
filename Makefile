SOURCE=ms.md
OUTPUT=ms.pdf
#BIB=/path/to/wherever.bib
#CSL=/path/to/wherever.csl
PFLAGS= --template plmt.tex #--bibliography=$(BIB) --csl=$(CSL)

PHONY: all

all: $(OUTPUT)

clean:
	rm marked_$(SOURCE)

$(OUTPUT): $(SOURCE)
	# Critic markup
	./critic.sh $< marked_$(SOURCE)
	# Compile
	pandoc marked_$(SOURCE) -o $@ $(PFLAGS)
