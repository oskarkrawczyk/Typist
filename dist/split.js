(function() {
  this.Typist.renderVariants = function(content, alts, options) {
    var cWords, className, end, i, maxP, out, part, parts, start, v, variant, variants, word, words, _, _i, _j, _k, _len, _len1, _len2, _ref;
    if (options == null) {
      options = {};
    }
    className = options.className || 'typist-element';
    cWords = content.split(' ');
    parts = {};
    start = 0;
    end = cWords.length;
    for (v = _i = 0, _len = alts.length; _i < _len; v = ++_i) {
      variant = alts[v];
      words = variant.split(' ');
      parts[v] = {
        start: 0,
        end: 0
      };
      for (i = _j = 0, _len1 = words.length; _j < _len1; i = ++_j) {
        word = words[i];
        if (word !== cWords[i]) {
          parts[v].start = i;
          break;
        }
      }
      _ref = words.reverse();
      for (i = _k = 0, _len2 = _ref.length; _k < _len2; i = ++_k) {
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
    for (i in alts) {
      variant = alts[i];
      words = variant.split(' ');
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
