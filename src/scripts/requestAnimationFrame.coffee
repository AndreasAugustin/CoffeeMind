# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file requestAnimationFrame
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

console.log 'loading requestAnimationFrame.coffee'

App = exports ? window

App.requestAnimationFrame = do () ->
    App.requestAnimationFrame || App.webkitRequestAnimationFrame || App.mozRequestAnimationFrame || App.oRequestAnimationFrame || App.msRequestAnimationFrame || (callback, element) ->
      return App.setTimeout (() ->
        callback(Date.now())
        ), 1000/60

App.cancelRequestAnimationFrame = do () ->
  App.cancelRequestAnimationFrame || App.webkitCancelRequestAnimationFrame || App.mozCancelRequestAnimationFrame || App.oCancelRequestAnimationFrame || App.msCancelRequestAnimationFrame || window.clearTimeout
