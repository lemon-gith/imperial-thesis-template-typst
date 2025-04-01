#import "/layout/titlepage.typ": *
#import "/layout/disclaimer.typ": *
#import "/layout/acknowledgement.typ": (
  acknowledgement as acknowledgement_layout
)
#import "/layout/abstract.typ": abstract as abstract_layout
#import "/utils/print_page_break.typ": *
#import "/style/colours.typ": imperial_blue


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

  pagebreak(to: "odd")

  // --- set preamble formatting ---
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "i"
  )
  counter(page).update(1)

  set page(header: context [
    #let page_num = counter(page).get().at(0);
    #if calc.even(page_num) [
      #text(fill: imperial_blue, counter(page).display())\
      #line(length: 100%, stroke: 0.5pt + imperial_blue)
    ]
  ], footer: [])

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

  show heading.where(
    level: 1
  ): it => {
    v(1cm)
    align(right, text(
      font: main-font, 9mm, fill: imperial_blue,
        it
      )
    )
    v(1cm)
  }

  // --- end preamble formatting ---

  // --- Preamble Sections ---

  abstract_layout(abstract)

  pagebreak(to: "odd")

  disclaimer_and_ai_tools(
    title: title,
    degree: degree_level,
    author: author,
    submissionDate: submissionDate,
    aiUsageBody: declarations
  )

  pagebreak(to: "odd")
  
  acknowledgement_layout(acknowledgement)

  pagebreak(to: "odd")

  // --- set outline configs ---

  show outline.entry.where(
    level: 1
  ): it => {
    set block(above: 2em)
    text(weight: "bold", it)
  }

  show outline.entry.where(
    level: 1
  ): set outline.entry(fill: none)

  // --- end outline configs ---

  // Table of Contents
  outline(title: "Contents", indent: auto)

  pagebreak(to: "odd")

  [= List of Acronyms]
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

  pagebreak(to: "odd")

  [= List of Figures]
  outline(title: "", target: figure.where(kind: image))

  pagebreak(to: "odd")

  [= List of Tables]
  outline(title: "", target: figure.where(kind: table))

  pagebreak(to: "odd")

  // --- End of Preamble ---

  // --- set formatting configs ---

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: main-font)
  set heading(numbering: "1.1.1")
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

  // --- Other ---

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

  pagebreak()
  // reset this indentation rule since it also acts on headings
  set par(first-line-indent: 0cm)

  // Appendix
  [  // nest in block: custom Appendix header rules
    #counter(heading).update(0)
    #set heading(numbering: "A")
    #show heading: it => {
      "Appendix " + counter(heading).display() + ": " + it.body
    }

    #include("/layout/appendix.typ")
  ]

  pagebreak()
  bibliography(
    "/thesis.bib",
    style: "vancouver"
  )
}
