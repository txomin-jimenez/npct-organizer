FileProcessor = require './file-processor'

module.exports = class MovieProcessor extends FileProcessor

  constructor: ->


  process: (filePath, folderPath) ->

    console.log "processing movie #{filePath} in #{folderPath}"
