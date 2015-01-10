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
notify = require 'gulp-notify'

config =
  src:
    main: ['src/scripts/*.coffee']
    spec: ['spec/**/*Spec.js']
    features: ['features/*']
    styles: ['./styles/*.sass']
    jquery: ['./bower_components/jquery/dist/jquery.min.js']
    normalize: ['./bower_components/normalize.css/normalize.css']
    fontAwesome: ['./bower_components/font-awesome/css/font-awesome.css']
    mainFiles:
      error: 'src/404.html'
      appleIcon: 'src/apple-touch-icon-precomposed.png'
      favIcon: 'src/favicon.ico'
      index: 'src/index.html'
  dest:
    folder: 'build'
    styles: './build/styles'
    scripts: './build/scripts'
    srcScriptsVendor: './src/scripts/vendor'
    srcStylesVendor: './src/styles/vendor'

gulp.task 'default', () ->
  # todo

# copy vendor files
gulp.task 'copyVendor', () ->
  gulp.src(config.src.jquery).pipe(gulp.dest(config.dest.srcScriptsVendor))
  gulp.src(config.src.normalize).pipe(gulp.dest(config.dest.srcStylesVendor))
  gulp.src(config.src.fontAwesome).pipe(gulp.dest(config.dest.srcStylesVendor))

# copies the game files to the build folder
gulp.task 'copy to build folder', () ->
  gulp.src(config.src.mainFiles.error).pipe(gulp.dest(config.dest.folder))
  gulp.src(config.src.mainFiles.appleIcon).pipe(gulp.dest(config.dest.folder))
  gulp.src(config.src.mainFiles.favIcon).pipe(gulp.dest(config.dest.folder))
  gulp.src(config.src.mainFiles.index).pipe(gulp.dest(config.dest.folder))

# Minify and copy all JavaScript
gulp.task 'build scripts', () ->
  gulp.src(config.src.main).pipe(coffee()).pipe(uglify()).pipe(gulp.dest(config.dest.scripts))

# runs jasmine-node tests
gulp.task 'jasmine', ->
  gulp.src(config.src.spec)
  .pipe(jasmine())
  .on 'error', notify.onError
    title: 'Jasmine test failed'
    message: 'One or more tests failed. See the cli for details.'


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





