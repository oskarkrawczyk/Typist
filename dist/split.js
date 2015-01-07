(function() {
  this.Typist.renderVariants = function(content, alts, options) {
    var alt, altWords, cWords, className, end, i, maxP, out, part, parts, start, v, variants, word, words, _, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref;
    if (options == null) {
      options = {};
    }
    className = options.className || 'typist-element';
    cWords = content.split(' ');
    altWords = [];
    for (_i = 0, _len = alts.length; _i < _len; _i++) {
      alt = alts[_i];
      alt || (alt = '');
      altWords.push(alt.split(' '));
    }
    parts = {};
    start = 0;
    end = cWords.length;
    for (v = _j = 0, _len1 = altWords.length; _j < _len1; v = ++_j) {
      words = altWords[v];
      parts[v] = {
        start: 0,
        end: 0
      };
      for (i = _k = 0, _len2 = words.length; _k < _len2; i = ++_k) {
        word = words[i];
        if (word !== cWords[i]) {
          parts[v].start = i;
          break;
        }
      }
      _ref = words.slice().reverse();
      for (i = _l = 0, _len3 = _ref.length; _l < _len3; i = ++_l) {
        word = _ref[i];
        if (word !== cWords[cWords.length - i - 1]) {
          parts[v].end = i;
          break;
        }
      }
    }
    maxP = {};
    for (_ in parts) {
      part = parts[_];
      if ((maxP.start == null) || maxP.start > part.start) {
        maxP.start = part.start;
      }
      if ((maxP.end == null) || maxP.end > part.end) {
        maxP.end = part.end;
      }
    }
    variants = [];
    for (i = _m = 0, _len4 = altWords.length; _m < _len4; i = ++_m) {
      words = altWords[i];
      variants.push(words.slice(parts[i].start, words.length - parts[i].end).join(' ').replace(/'/g, "\\'"));
    }
    out = cWords.slice(0, maxP.start).join(' ');
    out += " <span class='" + className + "' data-typist='" + (variants.join(',')) + "'>";
    out += cWords.slice(maxP.start, cWords.length - maxP.end).join(' ');
    out += "</span> ";
    out += cWords.slice(cWords.length - maxP.end).join(' ');
    return out;
  };

}).call(this);
