# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file input
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
# @param {jQuery} $
# @return {Object} API functions.
###
App.coffeeMind.input = do () ->
  _options = {}
  _$ = {}
  inputHandlers = {}
  keys =
    13: "KEY_ENTER"
    27: "KEY_ESCAPE"
    32: "KEY_SPACE"
    37: "KEY_LEFT"
    38: "KEY_UP"
    39: "KEY_RIGHT"
    40: "KEY_DOWN"

  ###
  # @method init
  # @param {Object} options
  ###
  init = ($) ->
    _options = App.settings
    _$ = $
    $board = _$("#game-screen .game-board")

    $board.bind "mousedown", (event) ->
      handleClick(event, "CLICK", event)
      return null

    $board.bind "touchstart", (event) ->
      handleClick(event, "TOUCH", event.targetTouches[0])
      return null

    _$(document).bind "keydown", (event) ->
      keyName = keys[event.keyCode]
      if keyName && _options.controls[keyName]
        event.preventDefault()
        trigger(_options.controls[keyName])
      return null

    return null

  ###
  # @method handleClick
  # @param {Event} event the event
  # @param {String} control the control
  # @param {Event} click the click
  ###
  handleClick = (event, control, click) ->
    # check if any action bound to the control
    action = _options.controls[control]
    imageSize = _options.imageSize

    if !action
      return null

    board = _$("#game-screen .game-board")[0]
    rect = board.getBoundingClientRect()

    # click position relative to board
    relX = click.clientX - rect.left
    relY = click.clientY - rect.top
    # coordinates
    mastermindX = Math.floor(relX / (rect.width - imageSize) * _options.cols)
    mastermindY = Math.floor(relY / rect.height * _options.rows)

    # trigger functions bound to action
    trigger(action, mastermindX, mastermindY)
    # prevent default click behavior
    event.preventDefault()
    return null

  ###
  # @method bind
  # @param {String} action
  # @param {method} handler
  ###
  bind = (action, handler) ->
    if !inputHandlers[action]
      inputHandlers[action] = []

    inputHandlers[action].push(handler)
    return null

  ###
  # @method trigger
  # @param {String} action
  ###
  trigger = (action) ->
    handlers = inputHandlers[action]
    args = Array.prototype.slice.call(arguments, 1)

    if handlers
      len = handlers.length
      for i in [0...len]
        handlers[i].apply(null, args)

    return null

  return{
    init: init,
    bind: bind
  }