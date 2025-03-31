#import "/metadata.typ" as md

#let titlepage(
  title: "",
  titleGerman: "",
  degree: "",
  report_level: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
) = {
  // Quality checks
  assert(degree in ("Bachelor", "Master"), message: "The degree must be either 'Bachelor' or 'Master'")
  assert(
    report_level in ("Interim", "Final"),
    message: "The report must be either an 'Interim' or 'Final'"
  )
  
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
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

  set par(leading: 0.5em)

  
  // --- Title Page ---
  v(1cm)
  align(center, image(md.logo_file, width: 26%))

  v(5mm)
  align(center, text(font: sans-font, 2em, weight: 700, md.university))

  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 100, md.department))
  
  v(15mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, degree + "’s Thesis in " + program))
  align(
    center, text(
      font: sans-font,
      1.3em, weight: 100,
      report_level + " Report"
    )
  )
  v(8mm)
  

  align(center, text(font: sans-font, 2em, weight: 700, title))
  

  align(center, text(font: sans-font, 2em, weight: 500, titleGerman))

  let entries = ()
  entries.push(("Author: ", author))
  entries.push(("Supervisor: ", supervisor))
  // Only show advisors if there are any
  if advisors.len() > 0 {
    entries.push(("Advisors: ", advisors.join(", ")))
  }
  entries.push(("Start Date: ", startDate.display("[day].[month].[year]")))
  entries.push(("Submission Date: ", submissionDate.display("[day].[month].[year]")))

  v(1cm)
  align(
    center,
    grid(
      columns: 2,
      gutter: 1em,
      align: left,
      ..for (term, desc) in entries {
        (strong(term), desc)
      }
    )
  )
}
