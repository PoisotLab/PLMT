---
title: This template is good. Use it. It's free.
short: Template
#bibliography: ...
#csl: ...
author:
  - family: Poisot
    given: Timothée
    affiliation: 1, 2
    email: tim@poisotlab.io
    id: tp
    orcid: 0000-0002-0735-5184
  - family: Author
    given: Second
    affiliation: 2,3
    id: sa
affiliation:
  - id: 1
    text: Université de Montréal, Département de Sciences Biologiques
  - id: 2
    text: Québec Centre for Biodiversity Sciences
  - id: 3
    text: University of Whatever
keyword:
  - k: markdown
  - k: pandoc
  - k: LaTeX
figure:
  - id: figure1
    caption: This is a figure.
    short: Example figure.
    file: figure1.png
date: Work in progress.
abstract: Writing manuscripts doesn't have to be awful. This template *tries* to provide good defaults for both the draft and preprint modes. Most of the information is contained in the YAML file.
---

And that's it. The `YAML` header is supposed to be complete, you only need to
edit it. More goodness will come soon.

# Critic Markup

These also show the different ways to have *CriticMarkup* show up in the
rendered document. For each author, you can define and `id` in the `YAML`
header. *CriticMarkup* prefixed with this `id` (no space), as in this example,
will be marked differently.

## Feature demo

The following lines should be highlighted in `draft`, but not in `preprint`
mode. With the exception of the highlights, which are always shown.

- {++addition++} {++@tp with an author name++}
- {--deletion--} {--@sa with an author name--}
- {~~@tp replacement~>with author name~~}
- {==this sentence==}{>>has an annotation<<}
- {==this sentence==}{>>@sa has a signed annotation<<}
- {==highlight only==}, and a {==@tp signed highlight==}
- {>>note only<<}, and a {>>@tp signed note<<}

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore
et dolore magna aliqua.

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim
id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum
dolore eu fugiat nulla pariatur.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore
et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.

# Figures

By default, figures are rendered at the end of the document, with each figure
taking up a whole page. There is a table of figures. It is recommended to use
autoref to cite figures: \autoref{figure1}.
