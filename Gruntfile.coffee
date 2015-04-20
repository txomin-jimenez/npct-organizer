'use strict'

module.exports = (grunt) ->

  # Show elapsed time at the end
  require('time-grunt') grunt

  # Load all grunt tasks
  require('load-grunt-tasks') grunt

  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.initConfig
    coffee:
      compile:
        files:
          'dist/syno-download-org.js': 'app/*.coffee'
    jshint:
      options:
        jshintrc: '.jshintrc'
        reporter: require('jshint-stylish')
      gruntfile: src: [ 'Gruntfile.js' ]
      js: src: [ '*.js' ]
      test: src: [ 'test/**/*.js' ]
    mochacli:
      options:
        reporter: 'nyan'
        bail: true
      all: [ 'test/*.js' ]
    watch:
      gruntfile:
        files: '<%= jshint.gruntfile.src %>'
        tasks: [ 'jshint:gruntfile' ]
      js:
        files: '<%= jshint.js.src %>'
        tasks: [
          'jshint:js'
          'mochacli'
        ]
      test:
        files: '<%= jshint.test.src %>'
        tasks: [
          'jshint:test'
          'mochacli'
        ]

  grunt.registerTask 'build', [
    'coffee'
  ]

  grunt.registerTask 'default', [
    'jshint'
    'mochacli'
  ]

  return