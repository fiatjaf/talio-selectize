delegator = null

dispatchChange = (elem, value) ->
  if value
    event = new CustomEvent 'change', 'detail': value: value
    elem.dispatchEvent event

class SelectizeWidget
  type: 'Widget'
  constructor: (@opts) ->
    @opts.dropdownParent = 'body'
  init: ->
    container = document.createElement 'div'

    elem = document.createElement 'select'
    elem.name = @opts.name or null
    if @opts.maxItems > 1
      elem.multiple = true
    container.appendChild elem

    if @opts['ev-change']
      delegator.addEventListener elem, 'change', @opts['ev-change']
      if not @opts.onChange
        @opts.onChange = dispatchChange.bind @, elem
      else
        @opts.onChange = (value) =>
          dispatchChange elem, value
          @opts.onChange value

    selectize = $(elem).selectize(@opts)[0].selectize
    if @opts.value
      selectize.setValue @opts.value, true

    return container

  update: (prev, container) ->
    elem = container.firstChild

    if @opts.key != prev.opts.key
      elem.selectize.destroy()

      if @opts['ev-change']
        delegator.addEventListener elem, 'change', @opts['ev-change']
        if not @opts.onChange
          @opts.onChange = dispatchChange.bind @, elem
        else
          @opts.onChange = (value) =>
            dispatchChange elem, value
            @opts.onChange value
      $(elem).selectize(@opts)

    else if @opts.options != prev.opts.options
      selectize = $(elem)[0].selectize
      selectize.addOption @opts.options
      selectize.refreshOptions !!@opts.openOnFocus
      optionsChanged = true

    if @opts.value != prev.opts.value or optionsChanged
      selectize = $(elem)[0].selectize
      selectize.setValue @opts.value, true

    return container
  destroy: ->

module.exports = (props) ->
  if not delegator
    console.log 'widget not initialized properly, please call .init(domDelegatorInstance) before calling this.'
  new SelectizeWidget props
module.exports.init = (delegatorPassedToUs) ->
  delegator = delegatorPassedToUs
