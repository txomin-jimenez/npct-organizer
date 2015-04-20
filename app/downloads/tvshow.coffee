Q                   = require 'q'
_                   = require 'lodash'
path                = require 'path'

DownloadItem        = require './download'
configuration       = require '../config'
fileMatches         = require '../file-matches'

module.exports = class TvShowItem extends DownloadItem

  constructor: (options) ->

    super

  getDownloadInfo: ->

    episode = @getShowEpisodeInfo()

    console.log "TV show -> #{episode.showName} - #{episode.season} - #{episode.name}"

    Q({name: "#{episode.showName}/#{episode.season}/#{episode.name}"})

  getDowloadDestination: ->

    tvShowsDestPath = configuration.get('tvshows_path')

    Q("#{tvShowsDestPath}/#{@info.name}")

  getShowEpisodeInfo: ->

    name = path.basename(@path)

    info = name.match(fileMatches.patterns.TVShow[0])

    showName = info[1].split(' - ')
    season = showName[1]
    showName = showName[0]

    episodeName = "#{info[3]}.#{showName}#{path.extname(@fileName)}"

    showName: showName.trim()
    season: season.trim()
    name: episodeName.trim()
