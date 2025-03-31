#let acknowledgement(body, main-font: "New Computer Modern") = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    number-align: center,
  )

  text(font: main-font, 5mm, weight: 700,
    heading(
    numbering: none,
    "Acknowledgements"
  ))

  v(15mm)

  body
}