# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file storage
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

###
# @method App.coffeeMind.storage
# @return {Object} API objects
###
App.coffeeMind.storage = do () ->
  db = App.localStorage

  ###
  # @method set
  # @param {String} key
  # @param {Object} value
  ###
  set = (key, value) ->
    value = JSON.stringify(value)
    db.setItem(key, value)
    return null

  ###
  # @method get
  # @param {String} key
  # @return {Object} the value for the key in the storage
  ###
  get = (key) ->
    value = db.getItem(key)
    try
      return JSON.parse(value)
    catch error
      return
    return null

  return {
    set: set
    get: get
  }


