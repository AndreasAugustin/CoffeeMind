# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file boardSpec
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

require('../node_modules/gulp-coffee/node_modules/coffee-script/lib/coffee-script/register')

App = require('../src/scripts/board.coffee')

describe 'Test for the board', () ->

  board = null
  settings = {}

  beforeEach ->
    board = App.coffeeMind.board
    settings.cols = 4
    settings.rows = 10
    settings.availableColours = 5
    settings.baseScore = 0
    settings.numColors = 4
    settings.allowMultipleColors = false
    App.settings = settings

  it 'sets board', () ->
    expect(board).not.toBe undefined
    return null

  it para1 = 'is possible to init the module', () ->
    result = initBoard(para1)

    expect(result).toBe null
    return null

  it para2 = 'is possible to print', () ->
    initBoard(para2)

    expect(typeof board.print).toBe 'function'

    result = board.print()

    expect(result).toBe null
    return null

  it para3 = "is possible to get the solution", () ->
    initBoard(para3)
    solution = board.getSolution()
    expect(solution).not.toBe undefined
    expect(Array.isArray(solution)).toBe true
    expect(solution.length).toBe settings.numColors
    if solution.length > 0
      expect(solution[0] >=0).toBeTruthy()
      expect(solution[0] < settings.availableColours).toBeTruthy()
    return null

  it para4 = "is possible to get the color at various positions", () ->
    initBoard(para4)
    x1 = 0
    y1 = 0
    result = board.getColor(x1, y1)

    expect(result).toBe -1
    return null

  it para5 = "is possible to set the next color", () ->
    initBoard(para5)
    x1 = 0
    y1 = 0

    board.nextColor(x1, y1)
    result = board.getColor(x1, y1)

    # Because x1 is 0 the expected result is -1
    expect(result).toBe -1
    return null



  # Helper method to init the board
  initBoard = (logMessage) ->
    board.init () ->
      console.log logMessage + " callback called"
    return null

