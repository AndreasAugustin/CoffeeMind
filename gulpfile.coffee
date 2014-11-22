# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file gulpfile
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
jasmine = require 'gulp-jasmine'
uglify = require 'gulp-uglify'
runSequence = require 'run-sequence'
shell = require 'gulp-shell'
coffeelint = require 'gulp-coffeelint'
cucumber = require 'gulp-cucumber'

config =
  src:
    main: ['src/**/*.coffee']
    spec: ['spec/**/*Spec.coffee']
    features: ['features/*']
  dist:
    folder: 'build'
    file: 'coffeeScript-namespace.js'
    minFile: 'coffeeScript-namespace.min.js'

gulp.task 'default', () ->
  # todo

# Minify and copy all JavaScript
gulp.task 'scripts', () ->
  gulp.src(config.src.main).pipe(coffee()).pipe(concat(config.dist.file)).pipe(gulp.dest(config.dist.folder))

# runs jasmine-node tests
gulp.task 'jasmine-node', ->
  shell.task('jasmine-node --coffee spec/*Spec.coffee')

# run all specs
gulp.task 'spec', (callback) ->
  runSequence('jasmine-node', callback)

# run coffee-lint
gulp.task 'coffee-lint', () ->
  gulp.src(config.src.main)
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())

# run cucumber tests
gulp.task 'cucumber', () ->
  gulp.src(config.src.features).pipe(cucumber('steps': 'features/step_definitions/*.js'))





