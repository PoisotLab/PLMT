This project intends to make the generation of high-quality preprints from
markdown, R markdown, and Julia markdown documents easy. Once downloaded, type
`make` to see the output. This will generate two pdf documents and one
OpenDocument file.

# Installation

To get started, you will need the python `pandoc-fignos`, `pandoc-eqnos`, and
`pandoc-tablenos` filters.

~~~ shell
make dependencies
~~~

Make sure that `pandoc` and `pandoc-citeproc` are installed, and that you have a
LaTeX installation. You will also need an installation of node. If you want to
use this template with reproducible documents, you will need either `knitr` or
`Weave.jl`.

# Document options

There are two important files to edit to specificy the manuscript informations.
First, `authors.yaml` should be self-explanatory; it contains the author names,
email addres for the corresponding author, and affiliations. The `infos.yaml`
file is for the manuscript title, keywords, etc. Finally, the `ABSTRACT` file
has the abstract. It can contain markdown formatting.

# Citations, tables, figures, ... {#sec:citation}

You can give sections identifiers with `{#sec:id}`, and cite them with `@sec:id` -- for example, this is section @sec:citation.

## Tables

Table legends go on the line after the table itself. To generate a reference to
the table, use `{#tbl:id}` -- then, in the text, you can use `{@tbl:id}` to
refer to the table. For example, the table below is @tbl:id. You can remove the
*table* in front by using `!@tbl:id`, or force it to be capitalized with
`\*tbl:id`.

| Using       |  produces |
|:------------|----------:|
| `@tbl:id`   |   @tbl:id |
| `!@tbl:id`  |  !@tbl:id |
| `\*@tbl:id` | \*@tbl:id |

Table: This is a table, and its identifier is `id` -- we can refer to it using
`{@tbl:id}`. Note that even if the table legend is written below the table
itself, it will appear on top in the compiled document. {#tbl:id}

## Equations

Equations can be referenced using the same syntax as tables, using the `eq`
prefix in place of `tbl`. For example:

$$ y = mx + b $$ {#eq:id}

We can refer to @eq:id in the text.

## Adding references

References go in the `references.json` file, at the root of the project.
References are cited with `@key`, where `key` is the unique identifier of the
reference. Both inline, like @hutc59hsr, and in brackets [@hutc57cr] can be
used.

## Figures

Figures can be used with the usual markdown syntax. After the path, you can use
`{#fig:id width=50%}` to specify the width and the reference. See @tbl:id for
how to cite. The code below in the markdown source produces @fig:id.



![This is a figure. Figures can have identifiers, and the width can be changed as well.](figure/histogram-1.pdf){#fig:id width=100%}

# Other elements

## Code blocks

You can use fenced code blocks to render code:

~~~ javascript
// Update affiliations
var print_affiliations = []
for (var af in affiliations) {
  var afobject = {}
  afobject.id = affiliations[af]
  afobject.text = af
  print_affiliations.push(afobject)
}
~~~

Note that code blocks have line numbers of the left, so this does not interfer
with the line numbers of the text (which are on the right).

## Track changes

You can use `make diff` to create a marked-up pdf document. The git revision can
be specified with the `TAG` variable of `make` (by default, the latest commit).
The other option is `AS`, which can be `draft` or `preprint`, to render the
marked-up version as a draft or as a preprint.

## Editorial marks

[Critic Markup][cm] is rendered:

Don't go around saying{-- to people that--} the world owes you a living. The
world owes you nothing. It was here first. {~~One~>Only one~~} thing is
impossible for God: To find {++any++} sense in any copyright law on the planet.
{==Truth is stranger than fiction==}{>>strange but
true<<}, but it is because Fiction is obliged to stick to possibilities; Truth
isn't.

Note that CriticMarkup is *not* rendered into OpenDocument.

[cm]: http://criticmarkup.com/

## Using with knitr, Weave.jl, ...

Just type `make`. If there is a `Rmd` or `Jmd` document with the same base name,
the makefile will render the markdown document for you. In fact, this document
*is* a `Rmd` file:


```r
summary(rnorm(250))
```

```
<<<<<<< HEAD
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## -2.723521 -0.712167 -0.007038 -0.049100  0.662052  3.038759
=======
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## -2.3210 -0.5724  0.1356  0.1311  0.8075  3.0701
>>>>>>> b4c81ad06ea8cb76f643342400d46edf705d8cee
```

Note that the extensions *must* be `Rmd` or `Jmd`, with an uppercase first
letter. Of course you will need `knitr` (for `R`) or `Weave.jl` (for `julia`).

Because of the way figures are refered to (using the `@fig:id` syntax), it is
better to generate the figure first, and then call it in the text, using
`fig.show='hide'`. The code below will generate @fig:chunk.


```r
plot(sort(rnorm(200)), type='l')
```

You can then use this figure:

![This is the figure created by the chunck `testfig`, so it is in `figure/testfig-1`. You can use different `dev` in the knitr chunk options, so it is possible to generate pdf or png figures.](figure/testfig-1.pdf){#fig:chunk width=100%}

With `knitr`, the `kable` function can create tables. If you add the caption
paragraph immediately below, then these tables can be cited. This is how we
produce @tbl:knit.


```r
data(iris)
kable(head(iris))
```



| Sepal.Length | Sepal.Width | Petal.Length | Petal.Width | Species |
|-------------:|------------:|-------------:|------------:|:--------|
|          5.1 |         3.5 |          1.4 |         0.2 | setosa  |
|          4.9 |         3.0 |          1.4 |         0.2 | setosa  |
|          4.7 |         3.2 |          1.3 |         0.2 | setosa  |
|          4.6 |         3.1 |          1.5 |         0.2 | setosa  |
|          5.0 |         3.6 |          1.4 |         0.2 | setosa  |
|          5.4 |         3.9 |          1.7 |         0.4 | setosa  |
Table: This is a table, and its identifier is `knit` -- we can refer to it using
`{@tbl:knit}`. Note that even if the table legend is written below the table
itself, it will appear on top in the compiled document. {#tbl:knit}

# References
