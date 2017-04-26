var fs = require('fs');
var path = require('path');

// Read the document
var readTo = path.normalize(process.argv[2])
var writeTo = path.normalize(process.argv[3])

// TODO: detect extension

function criticAddBegin(str, p1, p2, offset, s) {
  var mark = '\\add';
  if (p2) mark += '[' + p2 + ']';
  mark += '{';
  return mark;
}

function criticDelBegin(str, p1, p2, offset, s) {
  var mark = '\\remove';
  if (p2) mark += '[' + p2 + ']';
  mark += '{';
  return mark;
}

function criticHilBegin(str, p1, p2, offset, s) {
  var mark = '\\highlight';
  if (p2) mark += '[' + p2 + ']';
  mark += '{';
  return mark;
}

function criticNotBegin(str, p1, p2, offset, s) {
  var mark = '\\note';
  if (p2) mark += '[' + p2 + ']';
  mark += '{';
  return mark;
}

function criticClose(str, offset, s) {
  return "}"
}

fs.readFile(readTo, 'utf-8', function (err, data) {
  if (err) console.log(err);

  var addBegin = /\{\+\+( ?@(\w+))?( )?/g;
  var addEnd = /( )*\+\+\}/g;
  data = data.replace(addBegin, criticAddBegin);
  data = data.replace(addEnd, criticClose);

  var delBegin = /\{\-\-( ?@(\w+))?( )?/g;
  var delEnd = /( )*\-\-\}/g;
  data = data.replace(delBegin, criticDelBegin);
  data = data.replace(delEnd, criticClose);

  var hilBegin = /\{==( ?@(\w+))?( )?/g;
  var hilEnd = /( )*==\}/g;
  data = data.replace(hilBegin, criticHilBegin);
  data = data.replace(hilEnd, criticClose);

  var subBegin = /\{~~( ?@(\w+))?( )?/g;
  var subInter = /( )*~>( )*/g;
  var subEnd = /( )*~~\}/g;
  data = data.replace(subBegin, criticDelBegin);
  data = data.replace(subInter, '}\\add{');
  data = data.replace(subEnd, criticClose);

  var notBegin = /\{>>( ?@(\w+))?( )?/g;
  var notEnd = /( )*<<\}/g;
  data = data.replace(notBegin, criticNotBegin);
  data = data.replace(notEnd, criticClose);

  fs.writeFile(writeTo, data, 'utf-8', function (err) {
    if (err) console.log(err);
  });

});
