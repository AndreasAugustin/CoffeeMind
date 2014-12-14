# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file game
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

###*
# The board namespace
#
# @method App.game
# @return {Object} API functions.
###
App.coffeeMind.game = do () ->

  _options = {}
  _$ = {}
  _screens = []

  ###
  # @method setup
  ###
  setup = (options, $) ->
    _options = $.extend {}, options
    _$ = $
    _screens = App.coffeeMind.screens
    createBackground()
    return null

  ###
  # @method createBackground
  ###
  createBackground = () ->
    if !Modernizr.canvas
      return null

    canvas = document.createElement("canvas")
    ctx = canvas.getContext("2d")
    $background = _$("#game .background")

    canvas.width = $background.width()
    canvas.height = $background.height()

    ctx.scale($background.width(), $background.height())

    gradient = ctx.createRadialGradient(
      0.25, 0.15, 0.5,
      0.25, 0.15, 1)
    gradient.addColorStop(0, "rgb(55, 65, 50)")
    gradient.addColorStop(1, "rgb(0, 0, 0)")

    ctx.fillStyle = gradient
    ctx.fillRect(0, 0, 1, 1)

    ctx.strokeStyle = "rgba(255, 255, 255, 0.02)"
    ctx.strokeStyle = "rgba(0, 0, 0, 0, 2)"
    ctx.lineWidth = 0.008
    ctx.beginPath()


    for i in [0..2] by 0.020
      ctx.moveTo(i, 0)
      ctx.lineTo(i-1, 1)

    ctx.stroke()
    $background.append(canvas)

    return null

  ###
  # @method showScreen
  # @param {Int} screenId the screen id
  ###
  showScreen = (screenId) ->
    $activeScreen = _$("#game .screen.active")
    $screen = _$("#" + screenId)

    if $activeScreen.length > 0
      $activeScreen.removeClass("active")

    # extract screen parameters from arguments
    args = [_$].concat(Array.prototype.slice.call(arguments, 1))

    # run the screen module
    _screens[screenId].run.apply(_screens[screenId], args)

    # display the screen html
    $screen.addClass("active")


  return {
    showScreen: showScreen,
    setup: setup
  }