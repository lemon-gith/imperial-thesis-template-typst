// TODO: grab version I edited for my interim report
// TODO: add the Copyright Declaration thing into here (as a new page?)


#let disclaimer_and_ai_tools(
  title: "",
  degree: "",
  author: "",
  submissionDate: datetime,
  aiUsageBody: [],
  wantPagebreak: false,
  main-font: "New Computer Modern"
) = {
  // section title
  align(left, text(
    font: main-font, 5mm, weight: 700,
    heading(numbering: none, "Transparency in the use of AI tools")
  ))

  // --- AI Usage ---
  aiUsageBody

  v(20mm)

  if wantPagebreak {
    pagebreak()
  }

  // --- Disclaimer ---  
  text("I confirm that this " + degree + "’s thesis is my own work and I have documented all sources and material used.")

  v(10mm)
  // 'signature'
  grid(
      columns: 2,
      gutter: 1fr,
      "London, " + submissionDate.display("[day].[month].[year]"), author
  )
}
