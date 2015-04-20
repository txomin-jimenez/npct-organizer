(function() {
  'use strict';
  var nconf;

  nconf = require('nconf');

  module.exports = function(downloadPath) {
    var result;
    if (downloadPath != null) {
      console.log(downloadPath);
      result = 0;
    } else {
      console.log("Download path must be provided.");
      result = 1;
    }
    return result;
  };

}).call(this);
