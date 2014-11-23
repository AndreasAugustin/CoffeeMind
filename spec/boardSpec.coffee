# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file boardSpec
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

#require('../src/attach.module.coffee')

require('../node_modules/gulp-coffee/node_modules/coffee-script/lib/coffee-script/register')
Board = require('../src/board.coffee')

describe 'Test for the board', () ->
  it 'is possible to init call App.board', () ->
    result = typeof Board.board

    expect(result).toBe 'function'