# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file display.canvas
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

App = exports ? window

App.coffeeMind = App.coffeeMind || {}

###*
# The board namespace
#
# @method App.display
# @param {jQuery} $
# @return {Object} API functions.
###
App.coffeeMind.display = do () ->
  _$ = {}
  canvas = {}
  _options = {}
  ctx = {}
  cols = 0
  rows = 0
  availableColoursCount = 0
  imageSize = 0
  solutionCtx = {}
  availableColorsCtx = {}
  solutionCanvas = {}
  previousCycle = {}
  cursor = {}
  animations = []  # array with pointer to animation functions
  images = []
  numColors = 0
  srcPath = ""

  ###*
  # @method init init the module
  # @param {Object} options
  #     @option {Int} rows
  #     @option {Int} cols
  #     @option {Int} availableColours
  #     @option {Int} baseScore
  #     @option {Int} numColors
  #     @option {Int} imageSize
  #     @options {Array} images
  #     @option {Boolean} allowMultipleColors
  ###
  setup = ($) ->
    _$ = $
    _options = App.settings
    $boardElement = _$("#game-screen .game-board")

    cols = _options.cols
    rows = _options.rows
    srcPath = _options.srcPath
    numColors = _options.numColors
    availableColoursCount = _options.availableColours
    imageSize = _options.imageSize

    canvas = document.createElement("canvas")
    ctx = canvas.getContext("2d")
    _$(canvas).addClass("board")
    canvas.width = cols * imageSize + imageSize
    canvas.height = rows * imageSize

    $boardElement.append(createBackground())
    $boardElement.append(canvas)

    createSolutionElement()
    createAvailableColoursElement()

    images = _options.images

    previousCycle = Date.now()
    requestAnimationFrame(cycle)
    return null

  ###
  # @method cycle one animation cycle
  # @param {Time} time
  ###
  cycle = (time) ->
    animateCursor(time)
    renderAnimations(time, previousCycle)
    previousCycle = time
    requestAnimationFrame(cycle)
    return null

  ###
  # @method levelUp when the player reaches next level
  # @param {method} callback
  ###
  levelUp = (callback) ->
    beforeMethod = (pos) ->
      for y in [0..rows-1]
        for x in [0..Math.floor(pos * rows * 2)]
          if (x > 0 && x < cols) #boundary check
            clearImage(x, y) # clear all images

    renderMethod = (pos) ->
      ctx.save() # save state
      ctx.globalCompositeOperation = "lighter"

    addAnimation(1000, beforeMethod, renderMethod, done: callback)
    return null

  ###
  # @method addAnimation adds an animation to the animations array
  # @param {Int} runTime the run time of the animation
  # @param {} fncs
  ###
  addAnimation = (runTime, fncs) ->
    anim =
      runTime: runTime
      startTime: Date.now()
      pos: 0
      fncs: fncs

    animations.push anim
    return null

  ###
  # @method renderAnimation
  # @param {Time} time
  # @param {Time} lastTime
  ###
  renderAnimations = (time, lastTime) ->
    anims = animations.slice(0) # slice first
    n = anims.length

    if n > 0
      for i in [0..n-1]
        anim = anims[i]
        if anim.fncs.before
          anim.fncs.before(anim.pos)

        anim.lastPos = anim.pos
        animTime = (lastTime - anim.startTime)
        anim.pos = animTime / anim.runTime
        anim.pos = Math.max(0, Math.min(1, anim.pos))

      animations = [] #reset animations list
      for i in [0..n-1]
        anim = anims[i]
        anim.fncs.render(anim.pos, anim.pos - anim.lastPos)
        if anim.pos is 1
          if anim.fncs.done
            anim.fncs.done()

          else
            animations.push(anim)

    return null

  ###
  # @method createSolutionElement creates the solution element
  ###
  createSolutionElement = () ->
    $solutionElement = _$("#game-screen .solution")

    solutionCanvas = document.createElement("canvas")

    solutionCtx = solutionCanvas.getContext("2d")
    solutionCanvas.width = cols * imageSize
    solutionCanvas.height = imageSize
    solutionCtx.fillStyle = "rgba(255, 235, 255, 0.15)"

    for x in  [0..availableColoursCount-1]
      if x % 2 is 0
        solutionCtx.fillRect x * imageSize, x * imageSize, imageSize, imageSize

      $solutionElement.append(solutionCanvas);

    return null

  ###
  # @method createAvailableColoursElement creates the available colours element
  ###
  createAvailableColoursElement = () ->
    $availableColourElement = _$("#game-screen .availableItems")
    availableColours = document.createElement("canvas")

    availableColorsCtx = availableColours.getContext("2d")
    availableColours.width = availableColoursCount * imageSize
    availableColours.height = imageSize
    availableColorsCtx.fillStyle = "rgba(255, 235, 255, 0.15)"

    for x in [0..availableColoursCount-1]
      if x % 2 is 0
        availableColorsCtx.fillRect(
          x * imageSize, x * imageSize,
          imageSize, imageSize)

      $availableColourElement.append(availableColours);

    return null

  ###
  # @method createBackGround creates the background
  # @return {Element} the background
  ###
  createBackground = () ->
    background = document.createElement("canvas")
    bgCtx = background.getContext("2d")

    _$(background).addClass("background")
    background.width = cols* imageSize + imageSize
    background.height = rows * imageSize

    bgCtx.fillStyle = "rgba(255, 235, 255, 0.15)"

    for x in [0..cols-1]
      for y in [0..rows-1]
        if (x + y) % 2 is 0
          bgCtx.fillRect(cols * imageSize, y * imageSize, imageSize, imageSize)

    return background

  ###*
  # @method init init the module
  # @param {Object} options
  #     @option {Int} rows
  #     @option {Int} cols
  #     @option {Int} availableColours
  #     @option {Int} baseScore
  #     @option {Int} numColors
  #     @option {Int} imageSize
  #     @options {Array} images
  #     @option {Boolean} allowMultipleColors
  # @param {method} callback Callback method. Called at end of init.
  ###
  init = ($, callback) ->
    setup($)
    callback()
    return null

  ###*
  # @method reset resets the module
  # @param {Object} options
  #     @option {Int} rows
  #     @option {Int} cols
  #     @option {Int} availableColours
  #     @option {Int} baseScore
  #     @option {Int} numColors
  #     @option {Int} imageSize
  #     @options {Array} images
  #     @option {Boolean} allowMultipleColors
  ###
  reset = () ->
    _options = App.settings
    cols = _options.cols;
    rows = _options.rows;
    availableColoursCount = _options.availableColours;
    imageSize = _options.imageSize;
    canvas.width = canvas.width; # to reset the canvas

    hideSolution();
    return null

  ###
  # @method drawSolution draws the solution
  # @param {Array} guessColors
  ###
  drawSolution = (guessColors) ->
    image = images["images/forms_" + imageSize + ".png"]
    len = guessColors.length

    for x in [0..len-1]
      solutionCtx.drawImage(image, guessColors[x]*imageSize, 0, imageSize, imageSize, x * imageSize, 0, imageSize, imageSize)

    return null

  ###
  # @method hideSolution hides the solution
  ###
  hideSolution = () ->
    solutionCanvas.width = solutionCanvas.width # to reset the canvas
    return null

  ###
  # @method drawAvailableColours draws the available colours
  ###
  drawAvailableColours = () ->
    image = images[srcPath + "images/forms_" + imageSize + ".png"]

    for x in [0..availableColoursCount-1]
      availableColorsCtx.drawImage(image, x*imageSize, 0, imageSize, imageSize, x * imageSize, 0, imageSize, imageSize)
    return null

  ###
  # @method drawCheckColors draws the checked colors
  # @param {Object} correctColors
  ###
  drawCheckColors = (correctColors) ->
    rightColor = correctColors.rightColor
    rightPosition = correctColors.rightPosition
    rowNumber = correctColors.rowNumber
    z = cols

    # paint right colors
    ctx.fillStyle = "rgba(0, 12, 210, 0.15)";
    ctx.strokeStyle = "red";

    for x in [0..rightColor-1]
      ctx.strokeRect(z  * imageSize + x * imageSize/numColors, rowNumber * imageSize, imageSize/numColors, imageSize/2)
      ctx.fillRect(z  * imageSize + x * imageSize/numColors, rowNumber * imageSize, imageSize/numColors, imageSize/2)

    # paint right positions
    ctx.fillStyle = "red"
    ctx.strokeStyle = "rgba(0, 12, 210, 0.15)"

    for x in [0..rightPosition-1]
      ctx.strokeRect(z * imageSize + x * imageSize/numColors, rowNumber * imageSize + imageSize/2, imageSize/numColors, imageSize/2)

      ctx.fillRect(z * imageSize + x * imageSize/numColors, rowNumber * imageSize + imageSize/2, imageSize/numColors, imageSize/2)

    return null

  ###
  # @method myDrawImage
  # @param {Int} x the column
  # @param {Int} y the row
  # @param {Int} type the type
  ###
  myDrawImage = (x, y, type) ->
    #check if the last column is the clicked one
    if x is cols
      return null

    # check if there is no color chosen
    if type is -1
      ctx.clearRect(x * imageSize, y*imageSize, imageSize, imageSize)
      return null

    # draw image
    image = images["images/forms_" + imageSize + ".png"];
    ctx.drawImage(image, type * imageSize, 0, imageSize, imageSize, x * imageSize, y*imageSize, imageSize, imageSize)
    return null

  ###
  # @method renderCursor
  # @param {Int} x the column
  # @param {Int} y the row
  # @param {Int} opacity the opacity [0..1]
  ###
  renderCursor = (x, y, opacity) ->
    cursor = cursor || {}

    cursor.x = x;
    cursor.y = y;

    if ctx
      opacity = opacity || 0.8

      ctx.save()
      ctx.lineWidth = 0.05 * imageSize
      ctx.strokeStyle = "rgba(250, 250, 150," + opacity + ")"
      ctx.strokeRect((x + 0.05) * imageSize, (y + 0.05)  * imageSize, 0.9 * imageSize, 0.9 * imageSize)
      ctx.restore();

    return null

  ###
  # @method animateCursor
  # @param {Time} the time
  ###
  animateCursor = (time) ->
    if cursor
      opacity = 0.5 + (Math.sin(time / 400) + 1)
      renderCursor(cursor.x, cursor.y, opacity)

    return null

  ###
  # @method unRenderCursor
  # @param {Int} x the current column position
  # @param {Int} y the current row position
  # @param {Int} type the type of the cell
  ###
  unRenderCursor = (x, y, type) ->
    if ctx
      clearImage(x, y)
      myDrawImage(x, y, type)

    return null

  ###
  # @method unRenderCursor
  # @param {Int} x the current column position
  # @param {Int} y the current row position
  ###
  clearImage = (x, y) ->
    # check boundaries
    if x < 0 || x > cols || y < 0 || y > rows
      return null

    # remove images
    if(ctx)
      ctx.save()
      ctx.clearRect(x * imageSize, y * imageSize, imageSize, imageSize)
      ctx.restore()

    return null

  ###
  # @method gameOver
  # @param {method} callback
  ###
  gameOver = (callback) ->
    renderMethod = (pos) ->
      canvas.style.left = 0.2 * pos * (Math.random() - 0.5) + "em"
      canvas.style.top = 0.2 * pos * (Math.random() - 0.5) + "em"

    addAnimation(1000,
      render: renderMethod,
      done: () ->
        canvas.style.left = "0"
        canvas.style.top = "0"
        explode(callback))

    return null

  ###
  # @method explode
  ###
  explode = (callback) ->
    alert 'game over man :('
    return null

  return {
    init: init
    reset: reset
    myDrawImage: myDrawImage
    drawSolution: drawSolution
    drawAvailableColours: drawAvailableColours
    hideSolution: hideSolution
    drawCheckColors: drawCheckColors
    renderCursor: renderCursor
    unRenderCursor: unRenderCursor
    levelUp: levelUp
    gameOver: gameOver
  }