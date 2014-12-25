# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file screen.highscore
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

App.coffeeMind.screens = App.coffeeMind.screens || {}

App.coffeeMind.screens["highscore"] = do () ->
  _$ = {}
  _game = {}
  _storage = {}
  _numScores = 10
  _firstRun = true

  ###
  # @method setup
  # @param {jQuery} $
  ###
  setup = ($) ->
    _$ = $
    _game = App.coffeeMind.game
    _storage = App.coffeeMind.storage

    backButton = _$("#highscore footer button[name=back]")
    backButton.bind 'click', () ->
      _game.showScreen('main-menu')

  ###
  # @method run
  # @param {Int} score
  ###
  run = ($, score) ->
    if _firstRun is true
      setup($)
      _firstRun = false

    populateList()
    if typeof score isnt 'undefined'
      enterScore(score)

    return null

  ###
  # @method populateList
  ###
  populateList = () ->

    return null

  ###
  # @method score
  # @param {Int} score
  ###
  enterScore = (score) ->

    return null

  return {
    run: run
  }