SOURCE=ms.md
OUTPUT=ms.pdf
TYPE=draft # alt. value: preprint
PFLAGS= --template plmt.tex --variable=$(TYPE) --filter pandoc-citeproc

PHONY: all

all: $(OUTPUT)

clean:
	rm marked_$(SOURCE)

$(OUTPUT): $(SOURCE)
	# Critic markup
	./critic.sh $< marked_$(SOURCE)
	# Compile
	pandoc marked_$(SOURCE) -o $@ $(PFLAGS)
