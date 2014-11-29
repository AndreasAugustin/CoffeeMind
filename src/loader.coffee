# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file loader
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

$ = jQuery

###
# @module coffeeMind
###
App.coffeeMind = do () ->

  settings =
    rows: 10
    cols: 4
    baseScore: 100
    numColors: 4 # the number of colors to guess
    availableColours: 6 # the number ov available colors
    allowMultipleColors: false
    imageSize: undefined
    baseLevelTimer: 120000 # the time to solve the riddle
    baseLevelScore: 1500
    baseLevelExp : 1.05
    controls:
      KEY_UP: "nextColor"
      KEY_LEFT: "moveLeft"
      KEY_DOWN: "previousColor"
      KEY_RIGHT: "moveRight"
      KEY_ENTER: "checkColors"
      KEY_ESCAPE: "resetBoard"
      KEY_SPACE: "getSolution"
      CLICK: "nextColor"
      TOUCH: "nextColor"
  images = {}

  App.settings = settings

  Modernizr.addTest "standalone", () ->
    test = App.navigator.standalone isnt false
    console.log "Standalone test: " + test
    return test

  # extend yepnope with preloading
  yepnope.addPrefix "preload", (resource) ->
    resource.noexec = true
    console.log "preload: " + resource.url
    return resource

  # check if resource is a image
  numPreload = 0
  numLoaded = 0
  yepnope.addPrefix "loader", (resource) ->
    console.log "Loading: " + resource.url
    isImage = /.+\.(jpg|png|gif)$/i.test(resource.url)
    resource.noexec = isImage
    numPreload++
    resource.autoCallback = (e) ->
    console.log "Finished loading: " + resource.url
    numLoaded++
    if isImage
      image = new Image()
      image.src = resource.url
      images[resource.url] = image

    return resource

  # determine the image size from proto
  imageProto = document.getElementById("image-proto")
  rect = imageProto.getBoundingClientRect()
  console.log "proto-image bounding width (px):" + rect.width

  settings.imageSize = rect.width;

  getLoadProgress = () ->
    if numPreload > 0
      return numLoaded / numPreload
    else
      return 0

  console.log "started loading stage 1"
  # loading stage 1
  Modernizr.load
    load: ["loader!src/game.js"]
    test: Modernizr.standalone
    yep: "loader!src/screen.splash.js"
    nope: "loader!src/screen.install.js"
    complete: () ->
      App.coffeeMind.game.setup(settings, $)
      if Modernizr.standalone
        App.coffeeMind.game.showScreen("splash-screen", getLoadProgress)
        console.log "showScreen: splash-screen"
      else
        App.game.showScreen("install-screen")
        console.log "showScreen: install-screen"

      console.log("stage 1 loaded")

  console.log "started loading stage 2"
  # loading stage 2
  if Modernizr.standalone
    Modernizr.load
      load : ["loader!src/board.js"]
      load: [
          "loader!src/input.js",
          "loader!src/screen.main-menu.js",
          "loader!src/display.canvas.js",
          "loader!src/screen.game.js",
          "loader!images/forms_" + settings.imageSize + ".png"
      ],
      complete: () ->
        console.log "stage 2 loaded"


