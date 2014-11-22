# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file attach.module.step
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

myStepDefinitionsWrapper = () ->

  util = {}
  result = {}

  @Given /^The App\.namespace method$/, (callback) ->

    util = require('../../src/attach.module.coffee')
    if util is undefined
      callback.fail(new Error("Require did not work"))

    if typeof util.namespace isnt 'function'
      callback.fail(new Error('function namespace is not defined'))

    callback()
    return null

  @When /^A developer calls App\.namespace with "([^"]*)"$/, (arg1, callback) ->

    if typeof arg1 isnt "string"
      callback.fail(throw new Error("The argument arg1 is not of type string"))

    result = util.namespace(arg1)
    callback()
    return null

  @Then /^He should get an object App\.modules\.module1$/, (callback) ->

    if typeof result isnt 'object'
      callback.fail(throw new Error("App is no object. It is of type: " + typeof result))

    callback()
    return null

  return null

module.exports = myStepDefinitionsWrapper