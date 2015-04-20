FS                  = require 'fs'
Q                   = require 'q'
_                   = require 'lodash'

DownloadItem        = require './download'

module.exports = class DownloadCollection

  name: null

  path: null

  items: null

  constructor: (options) ->

    _.extend this, _.pick(options, [
      'name'
      'path'
    ])

    if not @path?
      throw new Error("DownloadCollection::constructor: 'path' is mandatory.")

    @items = []

  process: ->

    Q.all(_.map(@items, (item) ->
      item.process()
    ))

  add: (downloadItem) ->

    @items.push downloadItem if downloadItem?

  remove: (index)->

    delete @items[index]

  # get file list recusively
  _traverseDir: (path) ->

    Q.nfcall(FS.readdir, path)
    .then (files) =>

      Q.all(_.map(files, (file) =>

        if file[0] isnt '.'
          filePath = "#{path}/#{file}"

          Q.nfcall(FS.stat, filePath)
          .then (stat) =>

            if stat.isDirectory()
              @_traverseDir(filePath)
            else
              @add DownloadItem.new
                fileName: file
                path: path

      )).then (files) ->
        # just 'return' size of collection. items are now on @items
        _.size(files)
  ####

  # populate download collection from assigned 'path'
  fetch: ->

    @_traverseDir(@path)


  disposed: false

  dispose: ->

    return if @disposed

    for item in @items
      item.dispose()

    properties = [
      'items'
    ]

    delete this[prop] for prop in properties

    @disposed = true