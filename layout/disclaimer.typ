// TODO: grab version I edited for my interim report
// TODO: add the Copyright Declaration thing into here (as a new page?)


#let disclaimer_and_ai_tools(
  title: "",
  degree: "",
  author: "",
  submissionDate: datetime,
  aiUsageBody: [],
  wantPagebreak: false
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- AI Usage ---
  align(left, text(font: sans-font, 20pt, weight: 700,
    "Transparency in the use of AI tools")
  )

  aiUsageBody

  v(20mm)

  if wantPagebreak {
    pagebreak()
  }

  // --- Disclaimer ---  
  text("I confirm that this " + degree + "’s thesis is my own work and I have documented all sources and material used.")

  v(10mm)
  grid(
      columns: 2,
      gutter: 1fr,
      "London, " + submissionDate.display("[day].[month].[year]"), author
  )
}
