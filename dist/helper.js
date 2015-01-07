(function() {
  var load;

  load = function() {
    var el;
    el = document.querySelector(INSTALL_OPTIONS.location.selector);
    if (!el) {
      return;
    }
    el.innerHTML = Typist.renderVariants(el.textContent, INSTALL_OPTIONS.variants);
    return new Typist(el, {
      letterInterval: 60,
      textInterval: 3000
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
