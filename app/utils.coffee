FS          = require 'fs'
Q           = require 'q'
_           = require 'lodash'

# get file list recusively
traverseDir = (path) ->

  Q.nfcall(FS.readdir, path)
  .then (files) =>

    Q.all(_.map(files, (file) =>

      if file[0] isnt '.'
        filePath = "#{path}/#{file}"

        Q.nfcall(FS.stat, filePath)
        .then (stat) =>

          fileObj = {}
          if stat.isDirectory()
            fileObj.folder = file
            traverseDir(filePath)
            .then (files) ->
              fileObj.folder = file
              fileObj.files = files
              fileObj
          else
            fileObj.name = file
            fileObj

    )).then (files) ->
      # delete empty values from file list
      _.compact(files)
####

module.exports =

  traverseDir: traverseDir


