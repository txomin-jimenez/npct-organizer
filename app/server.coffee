configuration               = require './config'
DownloadCollection          = require './downloads/download-collection'
Q                           = require 'q'
_                           = require 'lodash'

http                        = require 'http'

module.exports = class SynoNewPctDownloadOrgServer

  constructor: ->

    @netServer = http.createServer @requestReceived

    port_ = 8000

    @netServer.listen(port_)

    console.log "Synology Newpct.com downloads organizer server started at #{port_}"

  requestReceived: (request, response) =>

    if request.url is '/process' and request.method is 'GET'
      @processDownloads()
      .then =>
        mresponse.writeHead(200, {"Content-Type": "application/json"})
        response.end(JSON.stringify({status: 0, message: 'Process finished'}))
      .fail =>

    else
      response.writeHead(200, {"Content-Type": "application/json"})
      response.end()

  processDownloads: ->

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


