# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file screen.game
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

App.coffeeMind.screens = App.coffeeMind.screens || {}

App.coffeeMind.screens["game-screen"] = do () ->
  _options = {}
  _$ = {}
  cursor = {}
  board = {}
  display = {}
  input = {}
  cols = 0
  rows = 0
  gameState =
    level: 0
    timer: {}

  ###
  # @method setup
  ###
  setup = ($) ->
    _options = App.settings
    _$ = $
    board = App.coffeeMind.board
    display = App.coffeeMind.display
    input = App.coffeeMind.input

    cols = _options.cols
    rows = _options.rows

    input.init(_$)
    input.bind("nextColor", nextColor)
    input.bind("previousColor", previousColor)
    input.bind("moveLeft", moveLeft)
    input.bind("moveRight", moveRight)
    input.bind("checkColors", checkColors)
    input.bind("resetBoard", reset)
    input.bind("getSolution", getSolution)

    bindButtons()
    return null

  ###
  # @method setLevelTimer
  # @param {method} reset
  ###
  setLevelTimer = (reset) ->
    if gameState.timer
      clearTimeout(gameState.timer)
      gameState.Timer = 0

    if(reset)
      gameState.startTime = Date.now()
      gameState.endTime =
        _options.baseLevelTimer * Math.pow(gameState.level, -0.05 * gameState.level)

    delta = gameState.startTime + gameState.endTime - Date.now()
    percent = (delta / gameState.endTime) * 100
    $progress = _$("#game-screen .time .indicator")
    if delta < 0
      gameOver()
    else
      $progress.width(percent + "%")
      gameState.timer = setTimeout(setLevelTimer, 30)

    return null

  ###
  # @method gameOver
  ###
  gameOver = () ->
    display.gameOver(() ->
      announce("Game over")
      return null )
  ###
  # @method addScore
  # @param {Int} points
  ###
  addScore = (points) ->
    nextLevelAt = Math.pow(
      _options.baseLevelScore, Math.pow(_options.baseLevelExp, gameState.level-1)
    )
    gameState.score += points
    if gameState.score >= nextLevelAt
      advanceLevel()

    updateGameInfo()
    return null

  ###
  # @method announce
  # @para {String} str the message
  ###
  announce = (str) ->
    $element = _$("#game-screen .announcement")
    $element.html(str)

    if Modernizr.cssanimations
      $element.removeClass("zoomfade")
      setTimeout (() ->
        $element.addClass("zoomfade")
        return null
        ), 1
    else
      $element.addClass("active")
      setTimeout ( () ->
        $element.removeClass("active")
        return null
        ), 1000

    return null

  ###
  # @method startGame
  ###
  startGame = () ->
    gameState =
      level: 0
      score: 0
      timer: 0
      startTime: 0
      endTime: 0

    updateGameInfo()
    setLevelTimer(true)

    board.init () ->
      # start the game
      display.init _$, () ->
        board.print()
        display.drawAvailableColours()
        advanceLevel()
        return null
      return null

    resetCursor()
    return null

  ###
  # @method advanceLevel
  ###
  advanceLevel = () ->
    gameState.level++
    if _options.availableColours < 8
      _options.availableColours++

    announce("Level " + gameState.level)
    updateGameInfo()

    gameState.startTime = Date.now()
    gameState.endTime = _options.baseLevelTimer * Math.pow(gameState.level, -0.05 * gameState.level)
    setLevelTimer(true)
    return null

  ###
  # @method updateGameInfo
  ###
  updateGameInfo = () ->
    _$("#game-screen .score span").html(gameState.score)
    _$("#game-screen .level span").html(gameState.level)
    return null

  ###
  # @method resetCursor
  ###
  resetCursor = () ->
    setCursor(0, rows-1)
    return null

  ###
  # @method checkColors
  ###
  checkColors = () ->
    check = board.checkColors()
    rightColor = check.rightColor
    rightPosition = check.rightPosition
    rowNumber = check.rowNumber

    if rightColor is -1 # not all cells have been set
      announce("Not all cells have been selected")
    else
      display.drawCheckColors(check)
      moveUp()
      addScore(20*rightPosition + 10*rightColor)

    if check.rightPosition is settings.numColors
      display.drawSolution(board.getSolution())
    else # no rows are left
      if(rowNumber is 0)
        gameOver()

    return null

  ###
  # @method getSolution
  ###
  getSolution = () ->
    display.drawSolution(board.getSolution())
    return null

  ###
  # @method bindButton
  ###
  bindButtons = () ->
    # checks if the chosen colors are right
    _$("#checkColors").bind 'click', () ->
      checkColors()
      return null

    # reset the game to restart board
    _$("#resetGame").bind 'click', () ->
      reset()
      return null

    # shows the solution
    _$("#showSolution").bind 'click', () ->
      getSolution()
      return null

    return null

  ###
  # @method reset
  ###
  reset = () ->
    resetCursor()
    board.reset () ->
      display.reset()
      return null

    return null

  ###
  # @method run
  # @param {jQuery} $
  ###
  run = ($) ->
    setup($)
    startGame()
    return null

  ###
  # @method nextColor
  # @param {Int} x
  # @param {Int} y
  ###
  nextColor = (x, y) ->
    if isNaN(x) || isNaN(y)
      x = cursor.x
      y = cursor.y


    color =  board.nextColor(x, y)
    if(color < -1)
      return null

    display.myDrawImage(x, y, color)
    unRenderCursor()
    setCursor(x, y)
    console.log("screen.game nextColor: Color increased at: Column: " + x + "Row: " + y + "New color: " + color)
    return null


  ###
  # @method unRenderCursor
  ###
  unRenderCursor = () ->
    x = cursor.x
    y = cursor.y
    display.unRenderCursor(x, y, board.getColor(x, y))

  ###
  # @method previousColor
  # @param {Int} x
  # @param {Int} y
  ###
  previousColor = (x, y) ->
    if(!x || !y)
      x = cursor.x
      y = cursor.y
    else
      setCursor(x, y)

    color =  board.previousColor(x, y)
    display.myDrawImage(x, y, color)
    console.log("Screen.game previousColor: Color decreased at: Column: " + x + "Row: " + y + "New color: " + color)
    return null

  ###
  # @method moveRight
  ###
  moveRight = () ->
    unRenderCursor()
    moveCursor(1,0)
    return null

  ###
  # @method moveLeft
  ###
  moveLeft = () ->
    unRenderCursor()
    moveCursor(-1,0)
    return null

  ###
  # @method moveUp
  ###
  moveUp = () ->
    unRenderCursor()
    setCursor(0, cursor.y-1)
    return null

  ###
  # @method moveCursor
  # @param {Int} x
  # @param {Int} y
  ###
  moveCursor = (x, y) ->
    x += cursor.x
    y += cursor.y

    setCursor(x, y)
    return null

  ###
  # @method setCursor sets the current cursor position.
  # @param {Int} x
  # @param {Int} y
  ###
  setCursor = (x, y) ->
    # check if cursor exists
    if !cursor
      cursor =
        x: x
        y: y

    if x >= 0 && x < cols && y >=0 && y < rows
      cursor.x = x
      cursor.y = y

    display.renderCursor(x, y, 0.8)
    console.log("Cursor set: column: " + cursor.x + "Row: " + cursor.y)
    return null

  return {
    reset: reset
    run: run }
