# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file plugins
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de
console.log "loading plugins.coffee"

console.log Modernizr

Modernizr.load
      load: "./src/requestAnimationFrame.js"
