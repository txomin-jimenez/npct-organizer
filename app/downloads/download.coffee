_                   = require 'lodash'
Q                   = require 'q'
path                = require 'path'

configuration       = require '../config'

fileMatches         = require '../file-matches'

module.exports = class DownloadItem

  name: null

  fileName: null

  path: null

  @fileIsVideo: (fileName) ->

    fileExtension = path.extname(fileName).replace('.','')

    fileMatches['video-extensions'].indexOf(fileExtension) > -1

  @getVideoClass: (fileName, filePath) ->

    MovieItem           = require './movie'
    TVShowItem          = require './tvshow'

    # all info is contained in folder name, filename is quite obscure
    name = path.basename(filePath)

    videoClass = 'Other'
    continue_ = true
    _.each fileMatches.patterns, (patterns, videoType) ->
      videoClass_ = videoType
      _.each patterns, (pattern) ->
        # if matches stop here; to stop _.each return false
        continue_ = not(name.match(pattern)? ? true : false)
        unless continue_
          videoClass = videoClass_
        continue_
      ####
      continue_
    ####

    if videoClass is 'Movie'
      MovieItem
    else if videoClass is 'TVShow'
      TVShowItem
    else
      DownloadItem


  @new: (options) ->

    if options.fileName?

      if DownloadItem.fileIsVideo(options.fileName)

        videoClass = DownloadItem.getVideoClass(options.fileName, options.path)

        new videoClass(options) if videoClass?

  constructor: (options) ->

    _.extend this, _.pick(options, [
      'name'
      'fileName'
      'path'
    ])


  process: ->

    @getDownloadInfo()
    .then (info) =>
      @info = info
      @getDowloadDestination()
    .then (destination) =>
      @moveDownload(destination)

  getDownloadInfo: ->

    Q()

  moveDownload: (destination)->

    sourcePath = configuration.get('downloads_path')

    console.log "move #{sourcePath}/#{@fileName} to #{destination}"

  disposed: false

  dispose: ->

    return if @disposed

    # properties = [


    # ]

    # delete this[prop] for prop in properties

    @disposed = true