# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file boardSpec
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

require('../node_modules/gulp-coffee/node_modules/coffee-script/lib/coffee-script/register')

Board = require('../src/board.coffee')

describe 'Test for the board', () ->

  board = null
  settings = {}

  beforeEach ->
    board = Board.board
    settings.cols = 4
    settings.rows = 10
    settings.availableColours = 5
    settings.baseScore = 0
    settings.numColors = 4
    settings.allowMultipleColors = false

  it 'sets board', () ->
    expect(board).not.toBe undefined

  it para1 = 'is possible to init the module', () ->
    result = initBoard(para1)

    expect(result).toBe null

  it para2 = 'is possible to print', () ->
    initBoard(para2)

    expect(typeof board.print).toBe 'function'

    result = board.print()

    expect(result).toBe null

  it para3 = "is possible to get the solution", () ->
    initBoard(para3)
    solution = board.getSolution()
    expect(solution).not.toBe undefined
    expect(Array.isArray(solution)).toBe true
    expect(solution.length).toBe settings.numColors

  # Helper method to init the board
  initBoard = (logMessage) ->
    return board.init settings, ->
      console.log logMessage + " callback called"

