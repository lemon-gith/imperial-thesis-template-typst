#import "../utils/titlepage_spacer.typ": spacer
#import "/metadata.typ" as md


#let titlepage(main-font: "New Computer Modern") = {
  // Quality checks
  assert(
    md.degree_level in ("Bachelor", "Master"),
    message: "The degree must be either 'Bachelor' or 'Master'"
  )
  assert(
    md.report_level in ("Interim", "Final"),
    message: "The report must be either an 'Interim' or 'Final'"
  )
  
  // set formatting configs
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
    numbering: none,
    number-align: center,
  )

  set text(font: main-font, size: 12pt, lang: "en")

  set par(leading: 0.5em)

  // pre-calculate based on the space needed for supervisors and advisors
  let (pretitle_space, postitle_space) = spacer(md.supervisors, md.advisors);

  // --- Title Page ---
  // place Imperial logo
  place(top + left, image("/style/images/icl_logo.svg", width: 45%))

  // set title and subtitle (if needed)
  v(pretitle_space)
  align(center,
    text(font: main-font, 2em, weight: 100, smallcaps(md.paper_title))
  )
  v(8mm)
  align(center,
    text(font: main-font, 1.4em, weight: 100, smallcaps(md.subtitle))
  )

  // add section for author and supervisor(s)
  v(postitle_space)
  align(center, text(font: main-font, 1em, weight: 100, [
    _Author_\
    #smallcaps(md.author)\
    #text(size: 11pt, [CID: #md.student_id])
  ]))

  v(1cm)
  align(center, text(font: main-font, 1em, weight: 100, [
    _Supervised by_\
    #md.supervisors.map(x => smallcaps(x)).join("\n")
  ]))

  v(1cm)
  // Only show advisors if there are any
  // this doesn't handle lots of advisors very well
  if md.advisors.len() > 0 {
    align(center, text(font: main-font, 1em, weight: 100, [
      _Advised by_\
      #md.advisors.map(x => smallcaps(x)).join("\n")
    ]))
  }

  let report_intensity = {
    if (md.report_level == "Interim") {"An Interim Report"} else {"A Thesis"}
  }

  place(bottom + center, [
    #align(center, text(font: main-font, 1em, weight: 100, [
      #report_intensity submitted in fulfillment of requirements for the degree of\
      #text(weight: 600, [#md.degree_type in #md.program])
    ]))

    #v(5mm)
    #align(center, text(font: main-font, 1em, weight: 100, [
      #md.department\
      #md.university\
      #md.submissionDate.year()
    ]))
  ])
}