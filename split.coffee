@Typist.renderVariants = (content, alts, options={}) ->
  className = options.className or 'typist-element'

  cWords = content.split(' ')

  parts = {}
  start = 0
  end = cWords.length
  for variant, v in alts
    words = variant.split(' ')

    parts[v] = {start: 0, end: 0}

    for word, i in words
      if word != cWords[i]
        parts[v].start = i
        break

    for word, i in words.reverse()
      if word != cWords[cWords.length - i - 1]
        parts[v].end = i
        break

  maxP = {}
  for _, part of parts
    if not maxP.start? or maxP.start > part.start
      maxP.start = part.start

    if not maxP.end? or maxP.end > part.end
      maxP.end = part.end

  variants = []
  for i, variant of alts
    words = variant.split(' ')
    variants.push words.slice(parts[i].start, words.length - parts[i].end).join(' ').replace(/'/g, "\\'")

  out = cWords.slice(0, maxP.start).join(' ')
  out += " <span class='#{ className }' data-typist='#{ variants.join(',') }'>"
  out += cWords.slice(maxP.start, cWords.length - maxP.end).join(' ')
  out += "</span> "
  out += cWords.slice(cWords.length - maxP.end).join(' ')

  return out
