path                        = require 'path'

fileExtensions              = require './file-extensions'

MovieProcessor              = require './movie-processor'
TvShowProcessor              = require './tvshow-processor'


module.exports = class FileProcessor

  @fileIsVideo: (filePath) ->

    fileExtension = path.extname(filePath).replace('.','')

    fileExtensions.video.indexOf(fileExtension) > -1

  @processFile = (file,folderPath='') ->

    if file.folder?
      folderPath = path.join folderPath, file.folder
      for file in file.files
        FileProcessor.processFile(file,folderPath)
    else

      if FileProcessor.fileIsVideo(file.name)
        # if MovieProcessor.fileIsMovie(file.name)
        new TvShowProcessor().process(file.name, folderPath)


  constructor: ->



  process: (filePath)->

    null


  disposed: false

  dispose: ->

    return if @disposed

    properties = [


    ]

    delete this[prop] for prop in properties