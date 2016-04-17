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
uglifycss = require 'gulp-uglifycss'
runSequence = require 'run-sequence'
coffeelint = require 'gulp-coffeelint'
cucumber = require 'gulp-cucumber'
sass = require 'gulp-ruby-sass'
notify = require 'gulp-notify'
imagemin = require 'gulp-imagemin'
del = require 'del'
jsdoc = require 'gulp-jsdoc'

config =
  src:
    main: ['src/scripts/*.coffee']
    spec: ['spec/**/*Spec.js']
    features: ['features/*']
    styles: ['./src/styles/*.sass']
    jquery: ['./bower_components/jquery/dist/jquery.min.js']
    normalize: ['./bower_components/normalize.css/normalize.css']
    fontAwesome: ['./bower_components/font-awesome/css/font-awesome.css']
    mainFiles:
      error: 'src/404.html'
      appleIcon: 'src/apple-touch-icon-precomposed.png'
      favIcon: 'src/favicon.ico'
      index: 'src/index.html'
    srcScriptsVendor: './src/scripts/vendor/*.js'
    srcStylesVendor: './src/styles/vendor/*.css'
    srcFontsTTF: './src/styles/fonts/*.ttf'
    srcFontsWOFF: './src/styles/fonts/*.woff'
  dest:
    srcStyles: './src/styles'
    srcScriptsVendor: './src/scripts/vendor'
    srcStylesVendor: './src/styles/vendor'
  build:
    folder: './build'
    styles: './build/styles'
    scripts: './build/scripts'
    stylesVendor: './build/styles/vendor'
    scriptsVendor: './build/scripts/vendor'
    fonts: './build/styles/fonts'
    images: './build/images'
  tasks:
    default: 'default'
    clean: 'clean'
    build: 'build'
    copyToSourceVendor: 'copyToSourceVendor'
    copyToBuildFolder: 'copy to build folder'
    sass: 'sass'
    sassCompressedCopyToBuild: 'run sass compressed and copy to build'
    buildScripts: 'build scripts and copy uglified to build'
    jsdoc: 'build jsdocumentation'


gulp.task config.tasks.default, () ->
  # todo

###
  Tasks for building
###

gulp.task config.tasks.jsdoc, () ->
  gulp.src("./src/scripts/*.js").pipe jsdoc('.documentation')

gulp.task config.tasks.build, [config.tasks.copyToBuildFolder, config.tasks.sassCompressedCopyToBuild, config.tasks.buildScripts], () ->
  # build task

#clean build folder
gulp.task config.tasks.clean, (callback) ->
  del([config.build.folder], callback)

# copies the game files to the build folder
gulp.task config.tasks.copyToBuildFolder, () ->
  gulp.src(config.src.mainFiles.error).pipe(gulp.dest(config.build.folder))
  gulp.src(config.src.mainFiles.appleIcon).pipe(gulp.dest(config.build.folder))
  gulp.src(config.src.mainFiles.favIcon).pipe(gulp.dest(config.build.folder))
  gulp.src(config.src.mainFiles.index).pipe(gulp.dest(config.build.folder))
  gulp.src(config.src.srcFontsTTF).pipe(gulp.dest(config.build.fonts))
  gulp.src(config.src.srcFontsWOFF).pipe(gulp.dest(config.build.fonts))
  gulp.src(config.src.srcStylesVendor).pipe(uglifycss()).pipe(gulp.dest(config.build.stylesVendor))
  gulp.src(config.src.srcScriptsVendor).pipe(gulp.dest(config.build.scriptsVendor))
  gulp.src('src/images/*')
  .pipe(imagemin(
      progressive: true,
      optimizationLevel: 3,
      interlaced: true
    ))
  .pipe(gulp.dest(config.build.images))

# run sass engine and copy the output to the build folder
gulp.task config.tasks.sassCompressedCopyToBuild, () ->
  gulp.src(config.src.styles)
  .pipe(sass("sourcemap=none": true, style: 'compressed'))
  .on 'error', (err) -> console.log(err.message)
  .pipe(gulp.dest(config.build.styles))

# Minify and copy all JavaScript
gulp.task config.tasks.buildScripts, () ->
  gulp.src(config.src.main).pipe(coffee()).pipe(uglify()).pipe(gulp.dest(config.build.scripts))


###
  Tasks for developing
###

# copy vendor files
gulp.task config.tasks.copyToSourceVendor, () ->
  gulp.src(config.src.jquery).pipe(gulp.dest(config.dest.srcScriptsVendor))
  gulp.src(config.src.normalize).pipe(gulp.dest(config.dest.srcStylesVendor))
  gulp.src(config.src.fontAwesome).pipe(gulp.dest(config.dest.srcStylesVendor))

# run sass engine
gulp.task config.tasks.sass, () ->
  gulp.src(config.src.styles)
  .pipe(sass("sourcemap=none": true))
  .pipe(gulp.dest(config.dest.srcStyles))

# run coffee-lint
gulp.task 'coffee-lint', () ->
  gulp.src(config.src.main)
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())

# Minify and copy all JavaScript
gulp.task 'buildTestScripts', () ->
  gulp.src("spec/*.coffee")
  .pipe(coffee())
  .pipe(gulp.dest("spec"))

# run cucumber tests
gulp.task 'cucumber', ['buildTestScripts'], () ->
  gulp.src(config.src.features).pipe(cucumber('steps': 'features/step_definitions/*.js'))

# runs jasmine-node tests
gulp.task 'jasmine', ['buildTestScripts'], () ->
  gulp.src(config.src.spec)
  .pipe(jasmine())
  .on 'error', notify.onError
    title: 'Jasmine test failed'
    message: 'One or more tests failed. See the cli for details.'




