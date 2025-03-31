#let abstract(body) = {
  let title = "Abstract"

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let main-font = "New Computer Modern"

  set text(
    font: main-font,
    size: 12pt, 
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- Abstract ---
  v(1fr)
  align(center, text(font: main-font, 1em, weight: "semibold", title))
  
  body
  
  v(1fr)
}
