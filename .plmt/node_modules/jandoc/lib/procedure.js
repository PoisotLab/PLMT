/*
 * The main Jandoc procedure.
 */

var fs      = require('fs'),
    cmdLine = require('child_process').exec,
    bashArgs,
    args;
 
/*
 * Test if a path is a directory.
 */
function isDir(path) {
  try {
    fs.readdirSync(path);
    return true;
  } catch (e) {
    return false;
  }
}

/*
 * Checks if a file has an extension.
 */
function hasFileExtension(path) {
  return /\.[^\/]+$/.test(path);
}

/*
 * Returns a file's extension.
 */
function getFileExtension(path) {
  return path.match(/\.[^\/]+$/)[0].slice(1);
}

/*
 * Removes the extension from a file name.
 */
function stripFileExtension(path) {
  return path.replace(/\.[^\/]+$/, '');
}

/*
 * Separates out a pure file name from a path.
 */
function getFileName(path) {
  return path.match(/\/?[^\/]+$/)[0].replace(/^\//, '');
}

/*
 * Removes -d and -o from bash args and returns the rest of the Pandoc options.
 */
function getPandocOptions(bashArgs) {
  return bashArgs.join(' ').replace(/(^|\s*)(\-o|\-\-output\-location)\s+[^\s]+/g, '')
                           .replace(/(^|\s*)(\-d|\-\-input\-data)\s+[^\s]+/g, '');
}

/*
 * Determine what the output file type should be after conversion.
 */
function getOutputFormat(formatVar, outputVar) {
  if (formatVar) {
    formatVar = formatVar[0];
  }
  if (outputVar) {
    outputVar = outputVar[0];
  }
  
  /*
   * If the user specified it, return that.
   */
  if (formatVar) {
    return formatVar;
  }
  
  /*
   * If the user didn't specify and the output is a folder, error.
   * If the output is a file with no extension, error.
   */
  if (isDir(outputVar) || !hasFileExtension(outputVar)) {
    console.error('No output filetype specified.');
    process.exit(1);
  }
  
  /*
   * If the output is a file with an extension, return the
   * extension.
   */
  return getFileExtension(outputVar);
}

/*
 * If Pandoc gives us an error warning, pass it on
 * to the user.
 */
function catchWarning(err, stdout, stderr) {
  if (stdout) {
    console.log(stdout.replace(/^pandoc:\s/, 'jandoc: ').replace(/\n*$/, ''));
  }

  if (stderr) {
    console.log(stderr.replace(/^pandoc:\s/, 'jandoc: ').replace(/\n*$/, '\njandoc: conversion was unsuccessful.'));
  }

  if (err) {
    process.exit(1);
  }
}

/*
 * Builds a Pandoc command line command.
 */
function buildCommand(inputFile, outputFile, outputFormat, argString) {
  return 'pandoc ' + inputFile + ' -o ' + stripFileExtension(outputFile) + '.' + outputFormat + ' ' + argString;
}

function runCommand(inputPath, outputPath, outputFormat, argString) {
  var files, command, i;
  
  /*
   * If the input path is a directory...
   */
  if (isDir(inputPath)) {
    
    /*
     * Get a list of files in the directory and loop over them.
     */
    files = fs.readdirSync(inputPath);
    for (i = 0; i < files.length; i += 1) {
      
      /*
       * For now, don't recurse into sub directories so
       * if the current file is not a directory...
       */
      if (!isDir(inputPath + '/' + files[i])) {
        
        /*
         * If the output path is intended to be a directory...
         */
        if (!hasFileExtension(outputPath)) {
          
          /*
           * If the output directory doesn't exist yet, create it.
           */
          if (!isDir(outputPath)) {
            fs.mkdirSync(outputPath);
          }
          
          /*
           * Build the command and run it.
           */
          command = buildCommand(inputPath + '/' + files[i], outputPath + '/' + files[i], outputFormat, argString);
          cmdLine(command, catchWarning);
          
        /*
         * Otherwise, the input is a file and the output is a file.
         * Build the command and run it.
         */
        } else {
          command = buildCommand(inputPath + '/' + files[i], outputPath, outputFormat, argString);
          cmdLine(command, catchWarning);
        }
      }
    }
  
  /*
   * If the input path is a file...
   */
  } else {
    
    /*
     * If the output is intended to be a directory...
     */
    if (!hasFileExtension(outputPath)) {
      
      /*
       * If the output directory doesn't exist yet, create it.
       */
      if (!isDir(outputPath)) {
        fs.mkdirSync(outputPath);
      }
      
      /*
       * Build the command and run it.
       */
      command = buildCommand(inputPath, outputPath + '/' + getFileName(inputPath), outputFormat, argString);
      cmdLine(command, catchWarning);
    
    /*
     * Otherwise, the input is a file and the output is a file.
     * Build the command and run it.
     */
    } else {
      command = buildCommand(inputPath, outputPath, outputFormat, argString);
      cmdLine(command, catchWarning);
    }
  }
}

/*
 * What to do when we have our arguments and are ready to go.
 */
function procedure() {
  var argString    = getPandocOptions(bashArgs),
      inputPath    = args['-d'][0],
      outputFormat = getOutputFormat(args['-t'], args['-o']);
  
  return runCommand(inputPath, args['-o'][0], outputFormat, argString);
}

module.exports = {
  "init" : function (rawArguments, parsedArguments) {
    bashArgs = rawArguments;
    args = parsedArguments;
    return procedure();
  }
};

