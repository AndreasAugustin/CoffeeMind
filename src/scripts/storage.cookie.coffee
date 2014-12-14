# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file storage.cookie
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
  cookieKey = "CoffeeMindData"

  ###
  # @method load
  # @return {Object} the data as JSON object
  ###
  load = () ->
    re = new RegExp("(?:^|;)\\s?" + escape(cookieKey) + "=(.*?)(?:;|$)", "i")
    match = document.cookie.match(re)
    data = ""
    if match
      data = unescape(match[1])
    else
      data = "{}"

    return JSON.parse(data)

  ###
  # @method set
  # @param {String} key
  # @param {Object} data
  ###
  set = (key, data) ->
    db = load()
    db[key] = data
    document.cookie = cookieKey + "=" + escape(JSON.stringify(db)) + "; path=/"
    return null

  ###
  # @method get
  # @param {String} key
  # @return {Object} the value for the key if exists, null else
  ###
  get = (key) ->
    db = load()
    value = db[key]
    if value
      return value
    else
      return null

  return {
    set: set
    get: get
  }
