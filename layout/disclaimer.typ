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
) = [
  // section title
  = Declaration of Originality

  #aiUsageBody

  // --- AI Usage ---

  #v(20mm)

  #if wantPagebreak {
    pagebreak()
  }

  // --- Disclaimer ---  
  I confirm that this #degree\’s thesis is my own work and I have documented all sources and material used.

  #v(10mm)
  // 'signature'
  #grid(
      columns: 2,
      gutter: 1fr,
      "London, " + submissionDate.display("[day].[month].[year]"), author
  )
]
