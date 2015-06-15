---
title: This template is good. Use it. It's free.
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
  - id: figure_1
    caption: This is a figure.
    file: figure1.png
date: Work in progress.
abstract: Writing manuscripts doesn't have to be awful.
---

And that's it. The `YAML` header is supposed to be complete, you only need to
edit it. More goodness will come soon.

# Critic Markup

These also show the different ways to have *CriticMarkup* show up in the
rendered document. For each author, you can define and `id` in the `YAML`
header. *CriticMarkup* prefixed with this `id` (no space), as in this example,
will be marked differently.

## Feature demo

- {++addition++} {++@tp with an author name++}
- {--deletion--} {--@sa with an author name--}
- {~~@tp replacement~>with author name~~}
- {==this sentence==}{>>has an annotation<<}
- {==this sentence==}{>>@sa has a signed annotation<<}
- {==highlight only==}, and a {==@tp signed highlight==}
- {>>note only<<}, and a {>>@tp signed note<<}



# Figures

By default, figures are rendered at the end of the document, with each figure
taking up a whole page. There is a table of figures.
