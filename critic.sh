#! /bin/sh

cat $1 > $2

# Additions
perl -pi -e 's/{\+\+@(\w+) (.+)\+\+}/\\add[$1]{$2}/gm' $2
perl -pi -e 's/{\+\+(.+)\+\+}/\\add{$1}/gm' $2

# Deletions
perl -pi -e 's/{\-\-@(\w+) (.+)\-\-}/\\remove[$1]{$2}/gm' $2
perl -pi -e 's/{\-\-(.+)\-\-}/\\remove{$1}/gm' $2

# Replacements
perl -pi -e 's/{~~@(\w+) (.+)~>(.+)~~}/\\change[$1]{$2}{$3}/gm' $2
perl -pi -e 's/{~~(.+)~>(.+)~~}/\\change{$1}{$2}/gm' $2

# Annotation
perl -pi -e 's/{==(.+)==}{>>@(\w+) (.+)<<}/\\annote[$2]{$1}{$3}/gm' $2
perl -pi -e 's/{==(.+)==}{>>(.+)<<}/\\annote{$1}{$2}/gm' $2

# Highlights
perl -pi -e 's/{==@(\w+) (.+)==}/\\hilight{\\small{\\color{red}$1} $2}/gm' $2
perl -pi -e 's/{==(.+)==}/\\hilight{$1}/gm' $2

# Notes
perl -pi -e 's/{>>@(\w+) (.+)<<}/\\note[$1]{$2}/gm' $2
perl -pi -e 's/{>>(.+)<<}/\\note{$1}/gm' $2
