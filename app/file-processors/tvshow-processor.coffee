FileProcessor   = require './file-processor'
namedRegExp     = require('named-regexp').named

module.exports = class TvShowProcessor extends FileProcessor

  tvShowMatches:
    standard: 'foo'

  constructor: ->


  process: (filePath, folderPath) ->

    console.log "processing tvshow #{folderPath} #{filePath}"

    prueba = "Show Name - S01E02 - My Ep Name"

    matches = @tvShowMatches.standard.exec(prueba)

    # console.log "processing tvshow #{showName} #{episode}"
