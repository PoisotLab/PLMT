#! /usr/bin/env python3

with open('bib.keys', 'r') as infile:
    data = infile.read()
    my_keys = data.splitlines()

import tammy
l = tammy.library()
l.export(keys=my_keys, path=".", output="citeproc-json")

keys_to_pop = ["URL", "ISSN", "files", "keyword", "archive", "license", "link", "member", "score", "subtitle", "source"]

import json
with open("default.json") as jf:
    refs = json.load(jf)
    for r in refs:
        for k in keys_to_pop:
            r.pop(k, None)

with open("default.json", "w") as jf:
    json.dump(refs, jf, sort_keys=True, indent=3)


