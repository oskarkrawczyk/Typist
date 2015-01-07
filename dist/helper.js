(function() {
  var load;

  load = function() {
    var el;
    el = document.querySelector(INSTALL_OPTIONS.location);
    if (!el) {
      return;
    }
    el.innerHTML = Typist.renderVariants(el.textContent, INSTALL_OPTIONS.variants, {
      className: 'eager-typist-element'
    });
    return new Typist(el.querySelector('eager-typist-element'), {
      letterInterval: 60,
      textInterval: 3000,
      selectClassName: 'eager-typist-selected'
    });
  };

  this.TypistInstallHelper = {
    init: function() {
      if (document.readyState === 'LOADING') {
        return window.addEventListener('DOMContentInteractive', load);
      } else {
        return load();
      }
    }
  };

}).call(this);
