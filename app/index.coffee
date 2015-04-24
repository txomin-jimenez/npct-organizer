configuration               = require './config'
DownloadCollection          = require './downloads/download-collection'
Q                           = require 'q'
_                           = require 'lodash'

Server                      = require './server'

module.exports = ->

  new Server()
