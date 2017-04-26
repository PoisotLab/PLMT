Jandoc
======

>A wrapper for the Pandoc document conversion tool with more options.

[Pandoc](https://github.com/jgm/pandoc) is a universal markup converter written
in Haskell.  It's a great tool for converting one kind of document into another
but I thought it might be nice if there was a way to use it to convert multiple
documents at once and expose its API through JavaScript.

Jandoc is written in Node.js and does just that.  The API is exposed in
two different ways:

1. You can call it through the command line, just like you might expect.
2. You have an object-oriented API you can use from within a JS module.

Dependencies
------------

1. Pandoc
2. Node.js
3. Npm (package manager for Node)

Pandoc is written in Haskell but there are multiple installation options. Of
course you'll have to install the Haskell platform.  Then, depending on your
preferred method of installation, you may or may not want to grab the
Haskell package manager Cabal.

Installation
------------

Jandoc is an Npm package.  So, once you have the dependencies listed above
installed, just do one of these: `~$ npm install jandoc`.

Command Line API
----------------

Calling Jandoc with your Unix command line is very similar to calling Pandoc with
the Unix command line although there are a couple of differences.

First, Jandoc requires your input filename argument to follow a flag.  So, whereas
Pandoc would only require this...

```bash
~$ pandoc inputFile.md -o outputFile.docx
```

...Jandoc requires this:

```bash
~$ jandoc -d inputFile.md -o outputFile.docx
```

That said, Jandoc allows you to pass in directory paths for both the `-d` (a.k.a, `--input-data`)
and `-o` (a.k.a, `--output-location`) arguments.

```bash
~$ jandoc -d inputDir -o outputDir --write docx
```

The above example converts all files in `inputDir` into files with corresponding names inside
`outputDir`.  Since both arguments are directory paths, we use the `--write` argument to specify
output file type.  If `outputDir` doesn't exist yet, it will be created.

**Note:** As of now, Jandoc does _not_ recursively delve into subfolders of your input directory
to convert files within them.

Apart from these small differences, the command line API is synonymous with the Pandoc
command line API.  Simply pass in other Pandoc arguments and they will be handed over to Pandoc.

JavaScript API
--------------

The JavaScript API allows you to access Jandoc functionality in two different ways.  First things
first though, you'll need to import it into Node:

```javascript
var jandoc = require('jandoc');
```

The above code brings in a function. The first way to access Jandoc functionality is to
pass an options object to that function.  For example:

```javascript
jandoc({
  "input"  : "./inputDir/",
  "output" : "./outputDir/",
  "write"  : "docx"
});
```

Your available options are equivalents of all of the Jandoc/Pandoc bash flags with the exceptions
that `--input-data` has become `input` and `--output-location` has become `output`.  Other than
that, the option keys are the long names of the bash flags in camel case rather than with dashes.
So if the bash flag is `--tab-stop`, the option key will be `tabStop`. If the flag does not take
an argument in the command line, set it to `true` in the options object.

One special case is the `--variable` flag as you can pass multiple variables to the command line
in the form of `--variable varName=value`.  In the options object, the value of your `variable`
key will also be an object wherein each subkey will be the variable name and the value will be its
value.

The other way you can access Jandoc functionality is by calling `jandoc.cmd` and passing it
a bash argument string.  For example:

```javascript
jandoc.cmd('-d inputDir -o outputDir --write docx');
```

This will pass your Jandoc command through Node straight into the Unix interface.
