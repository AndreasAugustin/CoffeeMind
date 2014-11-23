# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file attach.moduleSpec.coffee
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

util = require('../src/attach.module.coffee')

describe 'Test for attaching modules', () ->

  it 'is possible to call namespace as function', () ->
    result = typeof util.namespace

    expect(result).toBe 'function'

  it 'is able to create namespaces', () ->
    result = util.namespace("App.test")

    expect(result).not.toBe undefined