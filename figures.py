#! /usr/bin/env python

import sys
import re
import yaml

FILE = sys.argv[1]
YAML = sys.argv[2]
TYPE = sys.argv[3]

header = open(YAML, "r")
text = open(FILE, "r")
copy = open(FILE+"_NEW", "wt")

docs = yaml.load_all(header)
for doc in docs:
    if not doc == None:
        if 'figure' in doc.keys():
            for f in doc['figure']:
                for line in text:
                    my_regex = r"^!\{" + re.escape(f['id']) + r"\}$"
                    if re.search(my_regex, line, re.IGNORECASE):
                        if TYPE == 'preprint':
                            copy.write("\n\\begin{figure}[bt]\n")
                            copy.write("\t\\centering\n")
                            copy.write("\t\\includegraphics[width=\\columnwidth]{" + f['file'] + "}\n")
                            copy.write("\t\\caption{" + f['caption'] + "}\n")
                            copy.write("\t\\label{" + f['id'] + "}\n")
                            copy.write("\\end{figure}\n\n")
                    else:
                        copy.write(line)

header.close()
text.close()
copy.close()
