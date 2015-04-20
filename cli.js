#!/usr/bin/env node

'use strict';
require('coffee-script/register');

var meow = require('meow');
var synoDownloadOrganizer = require('./app/');

var cli = meow({
  help: [
    'Usage',
    '  syno-download-organizer <input>',
    '',
    'Example',
    '  syno-download-organizer Unicorn'
  ].join('\n')
});

synoDownloadOrganizer(cli.input[0]);
