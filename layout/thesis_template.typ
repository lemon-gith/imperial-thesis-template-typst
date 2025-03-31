#import "/layout/titlepage.typ": *
#import "/layout/disclaimer.typ": *
#import "/layout/acknowledgement.typ": acknowledgement as acknowledgement_layout
#import "/layout/abstract.typ": *
#import "/utils/print_page_break.typ": *

#let thesis(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  report_level: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  abstract_en: "",
  abstract_de: "",
  acknowledgement: "",
  transparency_ai_tools: "",
  is_print: false,
  body,
) = {
  titlepage(
    title: title,
    titleGerman: titleGerman,
    degree: degree,
    report_level: report_level,
    program: program,
    supervisor: supervisor,
    advisors: advisors,
    author: author,
    startDate: startDate,
    submissionDate: submissionDate
  )

  print_page_break(print: is_print, to: "even")

  disclaimer_and_ai_tools(
    title: title,
    degree: degree,
    author: author,
    submissionDate: submissionDate,
    aiUsageBody: transparency_ai_tools
  )

  print_page_break(print: is_print)
  
  acknowledgement_layout(acknowledgement)

  print_page_break(print: is_print)

  if abstract_en != "" {
    abstract(lang: "en")[#abstract_en]
  }
  if abstract_de != "" {
    abstract(lang: "de")[#abstract_de]
  }

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "i",
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )
  
  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: body-font)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      [Chapter ]
      numbering(
        el.numbering,
        ..counter(heading).at(el.location())
      )
    } else {
      it
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "alphanumeric")

  // --- Figures ---
  show figure: set text(size: 0.85em)
  
  // --- Table of Contents ---
  outline(
    title: {
      text(font: body-font, 1.5em, weight: 700, "Contents")
      v(15mm)
    },
    indent: 2em
  )

  
  v(2.4fr)
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)


  // Main body.
  set par(justify: true, first-line-indent: 2em)

  body

  // List of figures.
  pagebreak()
  heading(numbering: none)[List of Figures]
  outline(
    title:"",
    target: figure.where(kind: image),
  )

  // List of tables.
  pagebreak()
  heading(numbering: none)[List of Tables]
  outline(
    title: "",
    target: figure.where(kind: table)
  )

  // Appendix.
  pagebreak()
  heading(numbering: none)[Appendix A: Supplementary Material]
  include("/layout/appendix.typ")

  pagebreak()
  bibliography(
    "/thesis.bib",
    style: "vancouver"
  )
}
