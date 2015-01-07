load = ->
  el = document.querySelector(INSTALL_OPTIONS.location)
  return unless el

  el.innerHTML = Typist.renderVariants el.innerHTML, INSTALL_OPTIONS.variants

  new Typist el.querySelector('.typist-element'),
    letterInterval: 60
    textInterval:   3000

@TypistInstallHelper =
  init: ->
    if document.readyState is 'LOADING'
      window.addEventListener 'DOMContentInteractive', load
    else
      load()
