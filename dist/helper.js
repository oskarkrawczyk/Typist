(function() {
  var load, tries;

  tries = 0;

  load = function(options) {
    var el, styles, stylesHTML;
    el = document.querySelector(options.location);
    if (!el) {
      if (tries < 12) {
        tries++;
        setTimeout(function() {
          return load(options);
        }, 250);
      }
      return;
    }
    styles = document.createElement('div');
    stylesHTML = '<style>';
    if (options.typingStyle === 'cursor') {
      stylesHTML += ".eager-typist-element .eager-typist-selected {\n  display: none;\n}\n\n@keyframes eager-typist-blinking-cursor {\n  0% { opacity: 1.0; }\n  50% { opacity: 0.0; }\n  100% { opacity: 1.0; }\n}\n\n@-webkit-keyframes eager-typist-blinking-cursor {\n  0% { opacity: 1.0; }\n  50% { opacity: 0.0; }\n  100% { opacity: 1.0; }\n}\n\n.eager-typist-element:after {\n  content: \"\\00a0\";\n  display: inline-block;\n  margin-left: .125em;\n  width: .125em;\n  animation: eager-typist-blinking-cursor 1s step-start 0s infinite;\n  -webkit-animation: eager-typist-blinking-cursor 1s step-start 0s infinite;\n  background: #000;\n  background: " + options.cursorColor + ";\n}";
    }
    if (options.typingStyle === 'selection') {
      stylesHTML += ".eager-typist-element .eager-typist-selected {\n  font-style: normal;\n  color: #fff;\n  background: #000;\n  color: " + options.selectedColor + ";\n  background: " + options.selectedBackgroundColor + ";\n}";
    }
    stylesHTML += '</style>';
    styles.innerHTML = stylesHTML;
    document.body.appendChild(styles);
    el.innerHTML = Typist.renderVariants(el.textContent, options.variations, {
      className: 'eager-typist-element'
    });
    return new Typist(el.querySelector('.eager-typist-element'), {
      letterInterval: 60,
      textInterval: 3000,
      selectClassName: 'eager-typist-selected'
    });
  };

  this.TypistInstallHelper = {
    init: function(options) {
      if (document.readyState === 'loading') {
        return window.addEventListener('DOMContentInteractive', function() {
          return load(options);
        });
      } else {
        return load(options);
      }
    }
  };

}).call(this);
