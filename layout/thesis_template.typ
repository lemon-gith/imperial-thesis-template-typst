// #import "@preview/minitoc:0.1.0": *
#import "/layout/titlepage.typ": titlepage
#import "/content/preamble/disclaimers.typ": (
  copyright_declaration, originality_declaration
)
#import "/layout/basic_section.typ": section_layout
#import "/style/colours.typ": imperial_blue
#import "/utils/print_pagebreak.typ": print_pagebreak

#import "/layout/basic_formatting.typ": basic_formatting
#import "/layout/content_formatting.typ": content_formatting


#let thesis(
  sections,
  appendices,
  abstract_body: none,
  acknowledgements_body: none,
  acronyms: (),
  is_print: false,
  main-font: "New Computer Modern"
) = [  // Titlepage section
  #titlepage(
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

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Preamble section
  // --- outline configurations ---
  #show outline.entry.where(
    level: 1
  ): it => {
    set block(spacing: 2em)
    text(weight: "bold", it)
  }

  #show outline.entry.where(
    level: 1
  ): set outline.entry(fill: none)

  #show: basic_formatting.with(main-font: main-font, font-size: 11pt)

  // --- content start ---

  #section_layout("Abstract", abstract_body)

  #print_pagebreak(print: is_print, to: "odd")

  #originality_declaration()

  #print_pagebreak(print: is_print, to: "odd")

  #copyright_declaration()

  /*disclaimer_and_ai_tools(
    title: title,
    degree: degree_level,
    author: author,
    submissionDate: submissionDate,
    aiUsageBody: declarations_body
  )*/

  #print_pagebreak(print: is_print, to: "odd")
  
  #section_layout("Acknowledgements", acknowledgements_body)

  #print_pagebreak(print: is_print, to: "odd")

  // Table of Contents
  #outline(title: "Contents", indent: auto)

  #print_pagebreak(print: is_print, to: "odd")

  = List of Acronyms
  #grid(
    align: left,
    columns: 2,
    row-gutter: 5mm,
    column-gutter: 5mm,
    ..for pair in acronyms {(
      [#text(pair.first(), weight: "extrabold")],
      [#pair.last()]
    )}
  )

  #print_pagebreak(print: is_print, to: "odd")

  = List of Figures
  #outline(title: "", target: figure.where(kind: image))

  #print_pagebreak(print: is_print, to: "odd")

  = List of Tables
  #outline(title: "", target: figure.where(kind: table))

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Sections section
  // Reference first-level headings as "chapters"
  // TODO: check this for ic template
  #show ref: it => {
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

  // reset page numbering
  #set page(numbering: "1")
  #counter(page).update(1)

  // reset heading numbering
  #counter(heading).update(0)
  #set heading(numbering: "1.1.1")

  #show: content_formatting.with(
    is_print: is_print, main-font: main-font, header_section_prefix: [CHAPTER]
  )

  // Main body
  #for content_section in sections {
    content_section
  }

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Appendices sections
  // Appendix
  #counter(heading).update(0)
  #set heading(numbering: "A")

  #show: content_formatting.with(
    is_print: is_print, main-font: main-font, header_section_prefix: [APPENDIX]
  )

  // workaround for skipping print_pagebreak on final appendix
  #let last_appendix = appendices.last()
  #for appendix in appendices {
    appendix
    if appendix == last_appendix {
      print_pagebreak(print: is_print, to: "odd")
    }
  }
] + [  // Bibliography section
  #show: basic_formatting
  #bibliography("/thesis.bib", style: "ieee")
]
