# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file board
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de


App = exports ? window

App.coffeeMind = App.coffeeMind || {}
###*
# The board namespace
#
# @method App.board
# @return {Object} API functions.
###
App.coffeeMind.board = do () ->

  _options = {}
  cols = 0
  rows = 0
  baseScore = 0
  numColors = 0
  allowMultipleColor = false
  # 2-dim array with color (int) [x][y]. The x value points to column,
  # the y value points to row. The default value is -1 (no color)
  colors = []
  guessColors = []
  availableColoursCount = 0
  currentRow = 0

  ###*
  # @method init init the module
  # @param {Object} options
  #     @option {Int} rows
  #     @option {Int} cols
  #     @option {Int} availableColours
  #     @option {Int} baseScore
  #     @option {Int} numColors
  #     @option {Boolean} allowMultipleColors
  # @param {method} callback Callback method. Called at end of init.
  ###
  init = (callback) ->
    _options = App.settings
    rows = _options.rows
    cols = _options.cols
    availableColoursCount = _options.availableColours
    baseScore = _options.baseScore
    numColors = _options.numColors
    allowMultipleColor = _options.allowMultipleColors
    currentRow = rows-1

    setColors()
    createBoard()
    callback()
    return null

  ###*
  # @method reset resets the module to defaults
  # @param {Object} options
  #     @option {Int} availableColours
  #     @option {Int} baseScore
  #     @option {Int} numColors
  #     @option {Boolean} allowMultipleColors
  # @param {method} callback Callback method.
  ###
  reset = (callback) ->
    init(callback)
    return null

  ###*
  # @method setColors defines the colors which the player needs to guess
  ###
  setColors = () ->
    for x in [0...cols]
      type = randomColor()
      if allowMultipleColor isnt true
        while rowHasDifferentColors(guessColors, type) is false
          type = randomColor()

      guessColors[x] = type
    return null

  ###
  # @method rowHasDifferentColors checks if the row got different colors
  # @param {Array} row the row to check
  # @param {int} type the color type
  # @returns {boolean} true if the row got different colors, false else
  ###
  rowHasDifferentColors = (row, type) ->
    if row
      length = row.length
      if length < cols
        counter = length
      else
        counter = cols

      for y in [0...counter]
        if row[y] is type
          return false

    return true

  ###
  # @method randomColor creates a random color (random number between
  #                   0 - numberOfColors)
  # @return {Int} The color
  ###
  randomColor = () ->
    rand = Math.floor(Math.random() * availableColoursCount)
    return rand

  ###
  # @method createBoard creates the board
  ###
  createBoard = () ->
    board = []
    for y in [0...rows]
      board[y] = []
      for x in  [0...cols]
        board[y][x] = -1

    colors = board
    return null

  ###
  # @method print prints the solution
  ###
  print = () ->
    str = ""
    for x in [0...cols]
      str += guessColors[x]
      str += "\r\n"

    console.log(str)
    return null

  ###
  # @method checkGuessedColors Checks the row for the guessed Colors
  # @param {Int} rowNumber the row number
  # @return {Object} {rightColor: number, rightPosition: number,
  #                rowNumber: int}} The count of right guessed colors
  #                 (without right positions) and the count of right guessed
  #                    colors and positions, number of checked row
  ###
  checkGuessedColors = (rowNumber) ->
    rightColor = 0
    rightPosition = 0

    # security check if all colors are chosen for the row
    for x in [0...cols]
      if colors[rowNumber][x] is -1
        return {
          rightPosition: -1
          rightColor: -1
          rowNumber: rowNumber
        }

    for z in [0...cols]
      for y in [0...cols]
        if colors[rowNumber][z] is guessColors[y]
          if z is y
            rightPosition++
          else
            rightColor++

    return {
      rightPosition: rightPosition
      rightColor: rightColor
      rowNumber: rowNumber
    }

  ###*
  # @method checkColors Checks the colors for the current row and
  #           reduces the current row by 1
  ###
  checkColors = () ->
    checkGuessedColors(currentRow)
    currentRow--
    return null

  ###*
  # @method getSolution
  # @return {Array} the solution
  ###
  getSolution = () ->
    copy = []
    for x in [0...cols]
      copy[x] = guessColors[x]
    return copy

  ###*
  # @method nextColor changes the selected color of a cell (increases by one)
  # @param {Int} x the column
  # @param {Int} y the row
  # @return {Int} the new color
  ###
  nextColor = (x, y) ->
    changeColor(x, y, 1)
    return null

  ###*
  # @method previousColor changes the selected color of a cell
  #         (decreases by one)
  # @param {Int} x the column
  # @param {Int} y the row
  # @return {Int} the new color
  ###
  previousColor = (x, y) ->
    changeColor(x, y, -1)
    return null

  ###*
  # @method changeColor changes the color by a number
  # @param {Int} x the column
  # @param {Int} y the row
  # @param {Int} dColor the difference of the color
  # @return {Int} the new color
  ###
  changeColor = (x, y, dColor) ->
    if x is cols
      return -1

    if y isnt currentRow
      return -2

    currentColor = colors[y][x]
    nColor = currentColor + dColor

    if nColor >= availableColoursCount
      colors[y][x] = -1
      return colors[y][x]

    if nColor < 0
      colors[y][x] = availableColoursCount -1
      return colors[y][x]

    if allowMultipleColor isnt true
      _nextColor = currentColor
      while rowHasDifferentColors(colors[y], _nextColor) isnt true
        _nextColor++
        if (_nextColor >= availableColoursCount)
          colors[y][x] = -1
          return colors[y][x]

    colors[y][x] = _nextColor

    color = colors[y][x]

    return color

  ###
  # @method getColor
  # @param {Int} x the column
  # @param {Int} y the row
  # @return {Int} the color at x, y
  ###
  getColor = (x, y) ->
    color = colors[y][x]
    return color

  return {
    init: init
    print: print
    getSolution: getSolution
    nextColor: nextColor
    previousColor: previousColor
    checkColors: checkColors
    reset: reset
    getColor: getColor
  }
