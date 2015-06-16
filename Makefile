SOURCE=ms.md
OUTPUT=ms.pdf
TYPE=draft # alt. value: preprint
MARKED=$(SOURCE)_m.md
PFLAGS= --template plmt.tex --variable=$(TYPE) --filter pandoc-citeproc

PHONY: all

all: $(OUTPUT)

clean:
	rm $(MARKED)

$(MARKED): $(SOURCE)
	# Removes critic marks
	./critic.sh $< $@
	# Get yaml
	grep -Pzo '\-\-\-\n((.+)\n)+\-\-\-' $@ > paper.yaml
	# Replaces figures marks
	./figures.py $@ paper.yaml $(TYPE)
	mv $@_NEW $@
	# Remove yaml
	rm paper.yaml

$(OUTPUT): $(MARKED)
	pandoc $< -o $@ $(PFLAGS)
