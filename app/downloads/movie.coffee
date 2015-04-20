_                   = require 'lodash'
Q                   = require 'q'
path                = require 'path'

DownloadItem        = require './download'
configuration       = require '../config'
fileMatches         = require '../file-matches'

module.exports = class MovieItem extends DownloadItem

  constructor: (options) ->

    super

  getDownloadInfo: ->

    # console.log "Movie -> #{@fileName} #{@path}"
    fileExtension = path.extname(@fileName)

    console.log "Movie -> #{@getMovieName()}#{fileExtension}"

    Q({name: "#{@getMovieName()}#{fileExtension}"})

  getDowloadDestination: ->

    moviesDestPath = configuration.get('movies_path')

    Q("#{moviesDestPath}/#{@info.name}")

  getMovieName: ->

    name = path.basename(@path)

    _.reduce fileMatches.patterns.Movie, (memo, pattern) ->
      if name.match(pattern)
        name.match(pattern)[1].trim()

