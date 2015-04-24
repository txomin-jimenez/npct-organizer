(function() {
  var nconf;

  nconf = require('nconf');

  nconf.file({
    file: "/Users/tjd/.syno-download-org.json"
  });

  module.exports = nconf;

}).call(this);

(function() {
  module.exports = {
    'video-extensions': ['avi', 'flv', 'm1v', 'm2v', 'm4v', 'mkv', 'mov', 'mpeg', 'mpg', 'mpe', 'mp4', 'ogg', 'wmv'],
    patterns: {
      TVShow: [/^(.*)\[(.*)\]\[cap.(\d{3})\]\[(.*)\]/i],
      Movie: [/^(.*)\[(.*)\]\[(.*)\]\[(.*)\]\[(.*)\]/i, /^(.*)\[(.*)\]\[(.*)\]\[(.*)\]/i]
    }
  };

}).call(this);

(function() {
  'use strict';
  var DownloadCollection, Q, _, configuration;

  configuration = require('./config');

  DownloadCollection = require('./downloads/download-collection');

  Q = require('q');

  _ = require('lodash');

  module.exports = function() {
    var downloads, downloadsPath, moviesPath, tvShowsPath;
    console.log("...");
    downloadsPath = configuration.get('downloads_path');
    moviesPath = configuration.get('movies_path');
    tvShowsPath = configuration.get('tvshows_path');
    if ((downloadsPath == null) || ((moviesPath == null) && (tvShowsPath == null))) {
      console.log("invalid configuration");
      return -1;
    }
    console.log(" ");
    console.log("Processing downloads in '" + downloadsPath + "'");
    console.log(" ");
    downloads = new DownloadCollection({
      name: 'downloads',
      path: downloadsPath
    });
    return downloads.fetch().then(function(result) {
      return Q.allSettled(_.map(downloads.items, function(item) {
        return item.process();
      })).then(function(result) {
        console.log(" ");
        return console.log("Process finished succesfully.");
      }).fail(function(err) {
        console.log("Error");
        return console.log(err);
      });
    });
  };

}).call(this);

(function() {
  var FS, Q, _, traverseDir;

  FS = require('fs');

  Q = require('q');

  _ = require('lodash');

  traverseDir = function(path) {
    return Q.nfcall(FS.readdir, path).then((function(_this) {
      return function(files) {
        return Q.all(_.map(files, function(file) {
          var filePath;
          if (file[0] !== '.') {
            filePath = path + "/" + file;
            return Q.nfcall(FS.stat, filePath).then(function(stat) {
              var fileObj;
              fileObj = {};
              if (stat.isDirectory()) {
                fileObj.folder = file;
                return traverseDir(filePath).then(function(files) {
                  fileObj.folder = file;
                  fileObj.files = files;
                  return fileObj;
                });
              } else {
                fileObj.name = file;
                return fileObj;
              }
            });
          }
        })).then(function(files) {
          return _.compact(files);
        });
      };
    })(this));
  };

  module.exports = {
    traverseDir: traverseDir
  };

}).call(this);
