tries = 0
load = (options) ->
  el = document.querySelector(options.location)
  if not el
    if tries < 12
      tries++
      setTimeout ->
        load options
      , 250

    return

  styles = document.createElement 'div'
  stylesHTML = '<style>'

  if options.typingStyle is 'cursor'
    stylesHTML += """
      .cf-typist-element .cf-typist-selected {
        display: none;
      }

      @keyframes cf-typist-blinking-cursor {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
      }

      @-webkit-keyframes cf-typist-blinking-cursor {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
      }

      .cf-typist-element:after {
        content: "\\00a0";
        display: inline-block;
        margin-left: .125em;
        width: .125em;
        animation: cf-typist-blinking-cursor 1s step-start 0s infinite;
        -webkit-animation: cf-typist-blinking-cursor 1s step-start 0s infinite;
        background: #000;
        background: #{ options.cursorColor };
      }
    """

  if options.typingStyle is 'selection'
    stylesHTML += """
      .cf-typist-element .cf-typist-selected {
        font-style: normal;
        color: #fff;
        background: #000;
        color: #{ options.selectedColor };
        background: #{ options.selectedBackgroundColor };
      }
    """

  stylesHTML += '</style>'
  styles.innerHTML = stylesHTML

  document.body.appendChild styles

  el.innerHTML = Typist.renderVariants el.textContent, options.variations,
    className: 'cf-typist-element'

  new Typist el.querySelector('.cf-typist-element'),
    letterInterval: 60
    textInterval: 3000
    selectClassName: 'cf-typist-selected'

@INSTALL_SCOPE =
  init: (options) ->
    if document.readyState is 'loading'
      window.addEventListener 'DOMContentInteractive', -> load options
    else
      load options
