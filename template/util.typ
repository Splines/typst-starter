// adapted from https://typst.app/universe/package/parcio-thesis

#let setup-numbering(doc, num: "1", reset: true, alternate: true) = {
  let footer = if alternate {
    context {
      let page-count = counter(page).get().first()
      let page-align = if calc.odd(page-count) { right } else { left }
      align(page-align, counter(page).display(num))
    }
  } else {
    auto
  }

  set page(footer: footer, numbering: num)
  if reset { counter(page).update(1) }

  doc
}

#let roman-numbering(doc, reset: true, alternate: true) = setup-numbering(
  doc,
  num: "i",
  reset: reset,
  alternate: alternate,
)
#let arabic-numbering(doc, reset: true, alternate: true) = setup-numbering(
  doc,
  reset: reset,
  alternate: alternate,
)
