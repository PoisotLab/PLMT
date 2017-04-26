var fs = require('fs');
var path = require('path');
var yaml = require('js-yaml');

// Read the document
var writeTo = path.normalize(".metadata.yaml");

// Read the header
var infos = yaml.safeLoad(fs.readFileSync('infos.yaml', 'utf8'));
var autho = yaml.safeLoad(fs.readFileSync('authors.yaml', 'utf8'));

// Deal with authors and affiliations
var affiliations = {};
var current = 1;
for (var i = 0; i < autho.length; i++) {
  if(autho[i].affiliations) {
    for (var j = 0; j < autho[i].affiliations.length; j++) {
      if (affiliations[autho[i].affiliations[j]] == undefined) {
        affiliations[autho[i].affiliations[j]] = current
        current = current + 1
      }
    }
  }
}

// Update authors
for (var i = 0; i < autho.length; i++) {
  if (autho[i].affiliations) {
    for (var j = 0; j < autho[i].affiliations.length; j++) {
      autho[i].affiliations[j] = affiliations[autho[i].affiliations[j]];
    }
    autho[i].affiliations.sort()
  }
}

// Update affiliations
var print_affiliations = []
for (var af in affiliations) {
  var afobject = {}
  afobject.id = affiliations[af]
  afobject.text = af
  print_affiliations.push(afobject)
}

// Abstract
var abs = fs.readFileSync('ABSTRACT', 'utf8')
infos.abstract = abs//.replace(/[^\n]/gmi, " ")

// Update infos
infos.author = autho
infos.affiliation = print_affiliations
infos.cleveref = true

// Write to file
var json = yaml.safeDump(infos);
fs.writeFileSync('.metadata.yaml', json, 'utf8');
