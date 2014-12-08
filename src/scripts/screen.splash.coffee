# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file screen.splash
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

App.coffeeMind.screens = App.coffeeMind.screens || {}

App.coffeeMind.screens["splash-screen"] = do () ->
  game = {}
  _$ = $

  ###
  # @method setup
  # @param {method} getLoadProgress callback
  ###
  setup = ($, getLoadProgress) ->
    _$ = $
    game = App.coffeeMind.game
    $src = _$("#splash-screen")

    checkProgress = () ->
      p = getLoadProgress() * 100
      _$(".indicator", $src).css("width", p + "%")
      if(p is 100)
        _$(".continue", $src).css("display", "block")

        _$("#splash-screen").bind 'click', () ->
          game.showScreen('main-menu')
          return null

      else
        setTimeout(checkProgress, 30)

    checkProgress()
    return null

  ###
  # @method run
  # @param {method} getLoadProgress callback
  ###
  run = ($, getLoadProgress) ->
    setup($, getLoadProgress)
    return null

  return {
    run: run
  }