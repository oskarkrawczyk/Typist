load = (options) ->
  el = document.querySelector(options.location)
  return unless el

  styles = document.createElement 'div'
  stylesHTML = '<styles>'

  if options.showSelection
    stylesHTML += """
      .eager-typist-element .eager-typist-selected {
        font-style: none;
        color: #fff;
        background: #000;
        color: #{ options.selectedColor };
        background: #{ options.selectedBackgroundColor };
      }
    """

  else
    stylesHTML += """
      .eager-typist-element .eager-typist-selected {
        display: none;
      }
    """

  if options.showBlinkingCursor
    stylesHTML += """
      @keyframes eager-typist-blinking-cursor {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
      }

      @-webkit-keyframes eager-typist-blinking-cursor {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
      }

      .eager-typist-element:after {
        content: "\00a0";
        display: inline-block;
        margin-left: .125em;
        width: .125em;
        animation: eager-typist-blinking-cursor 1s step-start 0s infinite;
        -webkit-animation: eager-typist-blinking-cursor 1s step-start 0s infinite;
        background: #000;
        background: #{ options.cursorColor };
      }
    """

  stylesHTML += '</styles>'
  styles.innerHTML = stylesHTML

  document.body.appendChild styles

  el.innerHTML = Typist.renderVariants el.textContent, options.variants,
    className: 'eager-typist-element'

  new Typist el.querySelector('.eager-typist-element'),
    letterInterval: 60
    textInterval: 3000
    selectClassName: 'eager-typist-selected'

@TypistInstallHelper =
  init: (options) ->
    if document.readyState is 'LOADING'
      window.addEventListener 'DOMContentInteractive', -> load options
    else
      load options
