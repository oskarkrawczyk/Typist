class Utilities

  # some of the utilities methods are insipred or even copied from MooTools framework

  _addEvent: (element, event, fn, useCapture = false) ->
    element.addEventListener event, fn, useCapture

  _forEach: (array, fn, bind) ->
    i = 0
    l = array.length

    while i < l
      fn.call bind, array[i], i, array if i of array
      i++

  _each: (array, fn, bind) =>
    if array
      @_forEach array, fn, bind
      array

  _pass: (fn, args = [], bind) ->
    ->
      fn.apply bind, args

  _delay: (fn, delay, bind, args = []) ->
    setTimeout @_pass(fn, args, bind), delay

  _periodical: (fn, periodical, bind, args = []) ->
    setInterval @_pass(fn, args, bind), periodical

  _setHtml: (element, string) ->
    element.innerHTML = string

  _getHtml: (element) ->
    element.innerHTML

  _empty: (element) =>
    @_setHtml element, ""

  _fireEvent: (event, text) =>
    @options[event].call(@, text, @options) if @options[event]

  _extend: (object, properties) ->
    for key, val of properties
      object[key] = val
    object

class @Typist extends Utilities
  constructor: (element, options = {}) ->
    @options =
      typist:               element
      letterSelectInterval: 60
      interval:             3000
      selectClassName:      "selectedText"

    @options = @_extend @options, options

    @elements =
      typist: @options.typist

    @offsets =
      current:
        index: 0
        text: ""

    @setupDefaults() if @elements.typist

  setupDefaults: =>
    @variations = @fetchVariations @elements.typist

    @_delay @start, @options.interval

  start: =>
    @currentVariation = @variations[@offsets.current.index]
    @offsets.current.text = @currentVariation.split ''

    @selectText()

  next: =>
    @offsets.current.index++
    @offsets.current.index = @offsets.current.index % @variations.length

    @currentVariation = @variations[@offsets.current.index]
    @offsets.current.text = @currentVariation.split ''

  fetchVariations: (element) =>
    text       = element.getAttribute "data-typist"
    variations = text.split ","

    value      = @_getHtml element
    variations.splice 0, 0, value

    variations

  selectText: (index=0) =>
    offset = (@offsets.current.text.length - index) - 1
    if offset >= 0
      @selectOffset offset

    if offset > 0
      @_delay =>
        @selectText index + 1
      , @options.letterSelectInterval
    else
      @_delay =>
        @next()
        @typeText()
      , @options.letterSelectInterval

  selectOffset: (offset) =>
    text       = @offsets.current.text

    selected   = text.slice(offset, text.length).join ''
    unselected = text.slice(0, offset).join ''

    @_setHtml @elements.typist, """#{unselected}<em class="#{@options.selectClassName}">#{selected}</em>"""

  typeText: =>
    @typeTextSplit = @currentVariation.split ""

    @typeLetter()

    @_fireEvent "onSlide", @currentVariation

  typeLetter: (index=0) =>
    letter = @typeTextSplit[index]

    if index is 0
      @elements.typist.innerHTML = ''

    @elements.typist.innerHTML += letter

    if index + 1 is @typeTextSplit.length
      @_delay =>
        @selectText()
      , @options.interval
    else
      @_delay =>
        @typeLetter index + 1
      , @options.letterSelectInterval
