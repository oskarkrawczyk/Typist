load = ->
  el = document.querySelector(INSTALL_OPTIONS.location)
  return unless el

  el.innerHTML = Typist.renderVariants el.textContent, INSTALL_OPTIONS.variants,
    className: 'eager-typist-element'

  new Typist el.querySelector('eager-typist-element'),
    letterInterval: 60
    textInterval:   3000
    selectClassName: 'eager-typist-selected'

@TypistInstallHelper =
  init: ->
    if document.readyState is 'LOADING'
      window.addEventListener 'DOMContentInteractive', load
    else
      load()
