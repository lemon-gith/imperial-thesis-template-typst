#let abstract(body, main-font: "New Computer Modern") = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    number-align: center,
  )

  v(1fr)
  
  align(center, text(font: main-font, 1em, weight: "semibold", heading(
    numbering: none, "Abstract"
  )))

  body
  
  v(1fr)
}
