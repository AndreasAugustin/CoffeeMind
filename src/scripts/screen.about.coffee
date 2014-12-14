# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file screens.about
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

App.coffeeMind.screens = App.coffeeMind.screens || {}

App.coffeeMind.screens["about"] = do () ->
  game = {}
  _$ = $

  setup = ($) ->
    _$ = $
    _game = App.coffeeMind.game

    return null

  ###
  # @method run
  # @param {method} getLoadProgress callback
  ###
  run = ($) ->
    setup($)
    return null

  return {
  run: run
  }