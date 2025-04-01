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
    // check if this page starts a new chapter
    #let internal_page_num = here().page()
    #let is-start-chapter = query(
      heading.where(level:1)
    ).map(
      it => it.location().page()
    ).contains(internal_page_num)

    // no page number header on chapter start pages
    #if is-start-chapter {
      return
    }

    #let page_num = counter(page).get().at(0);
    #let alignment = if calc.even(page_num) {left} else {right}

    #align(alignment, text(fill: imperial_blue, counter(page).display()))
    #line(length: 100%, stroke: 0.5pt + imperial_blue)
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

  // --- Configure Heading and Page Numbering ---

  set page(numbering: "1")
  counter(page).update(1)

  set heading(numbering: "1.1.1")
  show heading.where(
    level: 1
  ): it => {
    pagebreak(weak: true)  // ensure all chapters start on new pages
    // ensure all chapters start on odd pages
    if calc.even(counter(page).get().at(0)) {
      pagebreak(to: "odd")
    }
    v(3cm)
    align(right, [
      #text(3cm, fill: imperial_blue, counter(heading).display())\
      #text(1cm, fill: imperial_blue, it.body)
    ])
    v(1cm)
  }
  set page(header: context [
    // check if this page starts a new chapter
    #let internal_page_num = here().page()
    #let is-start-chapter = query(
      heading.where(level:1)
    ).map(
      it => it.location().page()
    ).contains(internal_page_num)

    // get current page number
    #let page_num = counter(page).get().at(0);

    // select current chapter
    #let prev_ch_headings = selector(heading.where(level: 1)).before(here())
    #let ch_level = counter(prev_ch_headings)
    #let ch_headings = query(prev_ch_headings)
    // TODO: fix bug, whereby starting chapter page ch_level is wrong
    // this is due to the `before` being used, but I want the chapter heading
    // `here` on _that_ page

    #if ch_headings.len() == 0 {
      return
    }
    #let last_ch_heading = ch_headings.last()

    // Add chapter labels on each page
    #let chapter_circle = circle(
      fill: imperial_blue,
      radius: 8mm, align(
        horizon + center,
        text(ch_level.display(), fill: white, size: 1cm)
      )
    )
    #let chapter_rectangle = rect(
      fill: imperial_blue,
      height: 16mm,
      width: 12mm
    )
    #if calc.even(page_num) {
      place(left, dx: -30mm, dy: 3cm, chapter_rectangle)
      place(left, dx: -26mm, dy: 3cm, chapter_circle)
    } else {
      place(right, dx: 30mm, dy: 3cm, chapter_rectangle)
      place(right, dx: 26mm, dy: 3cm, chapter_circle)
    }

    // no page number header on chapter start pages
    #if is-start-chapter {
      return
    }

    // select current sub*-section
    #let prev_headings = selector(heading).before(here())
    #let curr_level = counter(prev_headings)
    #let headings = query(prev_headings)

    #let last_heading = headings.last()

    // make sure all heading text is 'branded'
    #set text(fill: imperial_blue)

    #if calc.even(page_num) [
      #counter(page).display()
      #h(1fr)
      CHAPTER #ch_level.display()\. #upper(last_ch_heading.body)
    ] else [
      #curr_level.display()\. #upper(last_heading.body)
      #h(1fr)
      #counter(page).display()
    ]
    #line(length: 100%, stroke: 0.5pt + imperial_blue)
  ], footer: [])

  // --- Text Formatting ---

  show math.equation: set text(weight: 400)

  set cite(style: "alphanumeric")

  show figure: set text(size: 0.85em)

  set par(justify: true, first-line-indent: 2em)

  // --- end formatting configs ---

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
