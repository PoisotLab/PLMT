
/*
=================================
Module for parsing bash args
=================================
*/

/*
 *
 * symlinkArgs(tree, links)
 *   - where tree is an object created by parseArgs()
 *   - where links is the symlinks argument from parseArgs()
 *   - returns an object to be returned by parseArgs()
 *     - {"_noflag" : [], "-h" : [], "--help" : this['-h'], ... }
 *
 */
function symlinkArgs(tree, links) {
  links.map(function (each) { // each = ['-h', '--help']
    var i, len = each.length;
    for (i = 0; i < len; i += 1) {
      if (tree[each[i]]) {
        each.map(function (item) {
          tree[item] = tree[each[i]];
        });
        break;
      }
    }
  });
  return tree;
}

/*
 *
 * parseArgs(args, symlinks)
 *   - where args is a string that came in from the bash command line
 *   - where symlinks is an array of two item arrays
 *     - these are command names that are equivalent
 *     - [ ['-h','--help'], ['-v','--version'] ]
 *   - returns an object
 *     - {"_noflag" : [], "-h" : [], "--help" : this['-h'], ... }
 *
 * Process:
 *  - drops in all the values with their respective flags
 *  - passes it off to symlinkArgs() to link equivalent arguments
 *
 */
function parseArgs(args, symlinks) {
  var argTree = {}, wantsFlagVal;
  if (!args.length) {
    argTree._noflag = 'null';
  }
  args.map(function (each) {
    if (each[0] === '-') {
      wantsFlagVal = each;
      argTree[wantsFlagVal] = [];
      return;
    }
    if (wantsFlagVal) {
      argTree[wantsFlagVal].push(each);
    } else {
      argTree._noflag = argTree._noflag || [];
      argTree._noflag.push(each);
    }
  });
  return symlinkArgs(argTree, symlinks);
}

module.exports = {
  parse: parseArgs
};
