'use strict'

configuration               = require './config'
DownloadCollection          = require './downloads/download-collection'
Q                           = require 'q'
_                           = require 'lodash'

module.exports = ->

  console.log "..."

  downloadsPath = configuration.get('downloads_path')
  moviesPath = configuration.get('movies_path')
  tvShowsPath = configuration.get('tvshows_path')

  if not downloadsPath? or (not moviesPath? and not tvShowsPath?)
    console.log "invalid configuration"
    return -1

  console.log " "
  console.log "Processing downloads in '#{downloadsPath}'"
  console.log " "

  # retrieve download folder items
  downloads = new DownloadCollection
    name: 'downloads'
    path: downloadsPath


  downloads.fetch()
  .then (result) ->

    # process each download item
    Q.allSettled(_.map(downloads.items, (item) ->
      item.process()
    )).then (result) ->
      console.log " "
      console.log "Process finished succesfully."
    .fail (err)->
      console.log "Error"
      console.log err

