#!/usr/bin/env node

'use strict';
require('coffee-script/register');

var meow = require('meow');
var synoDownloadOrganizer = require('./app/');

var cli = meow({
  help: [
    'Usage',
    '  nptct-organizer <input>',
    '',
    'Example',
    '  npct-organizer Unicorn'
  ].join('\n')
});

synoDownloadOrganizer(cli.input[0]);
