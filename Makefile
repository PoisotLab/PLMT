SOURCE=ms.md
HTML=ms.html
TYPE=draft# alt. value: preprint
TITLE=plmt
MARKED= $(TITLE)_temp.md
PFLAGS= --variable=$(TYPE) --filter pandoc-citeproc
OUTPUT= $(TITLE)_$(TYPE)_version.pdf
BIB=default.json

PHONY: all prepare

prepare:
	chmod +x *.{sh,py}

all: prepare $(OUTPUT)

clean:
	rm $(MARKED)
	rm bib.keys

$(BIB): bib.keys
	chmod +x generatebib.py
	./generatebib.py
	cat $@ | json_reformat > tmp.json
	mv tmp.json $@

bib.keys: $(MARKED)
	grep @[a-zA-Z0-9_:]* $< -oh --color=never | sort  | uniq | sed 's/@//g' > $@

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
	pandoc $< -o $@ $(PFLAGS) --template plmt.tex

