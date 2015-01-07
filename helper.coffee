load = ->
  el = document.querySelector(INSTALL_OPTIONS.location.selector)
  return unless el

  el.innerHTML = Typist.renderVariants el.textContent, INSTALL_OPTIONS.variants

  new Typist el,
    letterInterval: 60
    textInterval:   3000

@TypistInstallHelper =
  init: ->
    if document.readyState is 'LOADING'
      window.addEventListener 'DOMContentInteractive', load
    else
      load()
