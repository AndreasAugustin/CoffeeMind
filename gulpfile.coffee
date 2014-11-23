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
coffeelint = require 'gulp-coffeelint'
cucumber = require 'gulp-cucumber'
sass = require 'gulp-ruby-sass'

config =
  src:
    main: ['src/**/*.coffee']
    spec: ['spec/**/*Spec.js']
    features: ['features/*']
    styles: ['./styles/*.sass']
  dest:
    folder: 'build'
    file: 'coffeeScript-namespace.js'
    minFile: 'coffeeScript-namespace.min.js'
    styles: './build/styles'

gulp.task 'default', () ->
  # todo

# Minify and copy all JavaScript
gulp.task 'scripts', () ->
  gulp.src(config.src.main).pipe(coffee()).pipe(concat(config.dest.file)).pipe(gulp.dest(config.dest.folder))

# runs jasmine-node tests
gulp.task 'jasmine', ->
  gulp.src(config.src.spec)
  .pipe(jasmine())

# run all specs
gulp.task 'spec', (callback) ->
  runSequence('jasmine', callback)

# run coffee-lint
gulp.task 'coffee-lint', () ->
  gulp.src(config.src.main)
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())

# run cucumber tests
gulp.task 'cucumber', () ->
  gulp.src(config.src.features).pipe(cucumber('steps': 'features/step_definitions/*.js'))

# run sass engine
gulp.task 'sass', () ->
  gulp.src(config.src.styles)
  .pipe(sass("sourcemap=none": true))
  .pipe(gulp.dest(config.dest.styles))





