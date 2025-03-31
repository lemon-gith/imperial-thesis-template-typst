#import "/layout/titlepage.typ": *
#import "/layout/disclaimer.typ": *
#import "/layout/acknowledgement.typ": acknowledgement as acknowledgement_layout
#import "/layout/abstract.typ": abstract as abstract_page
#import "/utils/print_page_break.typ": *


#let thesis(
  title: "",
  subtitle: "",
  degree_type: "",
  degree_level: "",
  program: "",
  report_level: "",
  supervisors: (),
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  abstract: "",
  acknowledgement: "",
  declarations: "",
  acronyms: (),
  is_print: false,
  main-font: "New Computer Modern",
  body,
) = {
  titlepage(
    title: title,
    subtitle: subtitle,
    degree_type: degree_type,
    degree_level: degree_level,
    report_level: report_level,
    program: program,
    supervisors: supervisors,
    advisors: advisors,
    author: author,
    startDate: startDate,
    submissionDate: submissionDate
  )

  print_page_break(print: is_print, to: "odd")

  // --- set preamble formatting ---
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "i",
    number-align: center,
  )
  counter(page).update(1)

  // TODO: isn't this the setting on each page anyways?
  // propagate it instead of setting it here
  set text(
    font: main-font,
    size: 11pt,
    lang: "en"
  )

  set par(
    leading: 1.2em,
    justify: true
  )

  // --- end preamble formatting ---

  abstract_page(abstract)

  print_page_break(print: is_print, to: "odd")

  disclaimer_and_ai_tools(
    title: title,
    degree: degree_level,
    author: author,
    submissionDate: submissionDate,
    aiUsageBody: declarations
  )

  print_page_break(print: is_print, to: "odd")
  
  acknowledgement_layout(acknowledgement)

  print_page_break(print: is_print, to: "odd")

  show outline.entry.where(
    level: 1
  ): it => {
    set block(above: 2em)
    text(weight: "bold", it)
  }

  show outline.entry.where(
    level: 1
  ): set outline.entry(fill: none)

  // Table of Contents
  outline(
    title: {
      text(font: "New Computer Modern", 1.5em, weight: 700, "Contents")
      v(15mm)
    },
    indent: auto
  )

  print_page_break(print: is_print, to: "odd")

  // List of acronyms
  heading(numbering: none)[List of Acronyms]
  v(1cm)
  grid(
    align: left,
    columns: 2,
    row-gutter: 5mm,
    column-gutter: 5mm,
    ..for pair in acronyms {(
      [#text(pair.first(), weight: "extrabold")],
      [#pair.last()]
    )}
  )

  print_page_break(print: is_print, to: "odd")

  // List of figures
  heading(numbering: none)[List of Figures]
  outline(
    title:"",
    target: figure.where(kind: image),
  )

  print_page_break(print: is_print, to: "odd")

  // List of tables
  heading(numbering: none)[List of Tables]
  outline(
    title: "",
    target: figure.where(kind: table)
  )

  print_page_break(print: is_print, to: "odd")

  // --- set formatting configs ---

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: main-font)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  // TODO: fix this for ic template
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

  show math.equation: set text(weight: 400)

  set cite(style: "alphanumeric")

  show figure: set text(size: 0.85em)

  set par(justify: true, first-line-indent: 2em)

  // --- end formatting configs ---
  
  // set page numbering for content pages
  set page(numbering: "1")
  counter(page).update(1)

  // Main body
  body

  // TODO: revisit how the Appendix is rendered
  // Appendix
  pagebreak()
  heading(numbering: none)[Appendix A: Supplementary Material]
  include("/layout/appendix.typ")

  pagebreak()
  bibliography(
    "/thesis.bib",
    style: "vancouver"
  )
}
