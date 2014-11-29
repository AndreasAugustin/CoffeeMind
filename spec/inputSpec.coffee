# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file inputSpec
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

require('../node_modules/gulp-coffee/node_modules/coffee-script/lib/coffee-script/register')
jsdom = require('jsdom')

describe 'Test for the board', () ->

  input = null
  settings = {}
  $ = {}

  beforeEach (done)->
    settings.cols = 4
    settings.rows = 10
    settings.availableColours = 5
    settings.baseScore = 0
    settings.numColors = 4
    settings.allowMultipleColors = false

    jsdom.env
      html: '<html><body></body></html>'
      scripts: ['../bower_components/jquery/dist/jquery.js']
      done: (err, window) ->
        if err
          console.log err
        $ = window.jQuery
        done()

    Input = require('../src/input.coffee')
    input = Input.input

  it 'sets input', () ->
    expect(input).not.toBe undefined

  it 'is possible to init the module', () ->
    result = initInput()
    expect(result).toBe null

  # Helper method to init the board
  initInput = () ->
    return input.init $, {}