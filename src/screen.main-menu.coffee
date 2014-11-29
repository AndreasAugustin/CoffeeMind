# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file screen.main-menu
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

App.coffeeMind.screens = App.coffeeMind.screens || {}

App.coffeeMind.screens["main-menu"] = do () ->

  _$ = {}
  game = {}

  ###
  # @method setup
  # @param {jQuery} $
  ###
  setup = ($) ->
    _$ = $
    game = App.coffeeMind.game

    _$("#main-menu ul.menu").bind "click", (e) ->
      if e.target.nodeName.toLowerCase() is "button"
        action = e.target.getAttribute('name')
        game.showScreen(action)
    return null

  run = ($) ->
    setup($)
    return null

  return{
    run: run
  }