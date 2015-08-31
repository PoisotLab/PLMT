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
            for line in text:
                mfig = False
                for f in doc['figure']:
                    my_regex = r"^!\{" + re.escape(f['id']) + r"\}$"
                    if re.search(my_regex, line, re.IGNORECASE):
                        mfig = True
                        print line
                        if TYPE == 'preprint':
                            ftype = "figure"
                            fwidth = "\\columnwidth"
                            if "wide" in f.keys():
                                ftype = "figure*"
                                fwidth = "\\textwidth"
                            copy.write("\n\\begin{" + ftype + "}[bt]\n")
                            copy.write("\t\\centering\n")
                            print f
                            copy.write("\t\\includegraphics[width=" + fwidth + "]{" + f['file'] + "}\n")
                            copy.write("\t\\caption{" + f['caption'] + "}\n")
                            copy.write("\t\\label{" + f['id'] + "}\n")
                            copy.write("\\end{" + ftype + "}\n\n")
                if not mfig:
                    copy.write(line)


header.close()
text.close()
copy.close()
