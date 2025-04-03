#import "/style/colours.typ": imperial_blue

#let basic_formatting(doc,
  main-font: "New Computer Modern", font-size: 11pt
) = {
  // --- page settings ---
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

  show heading.where(
    level: 1
  ): it => {
    v(1cm)
    align(right, text(9mm, fill: imperial_blue, it))
    v(1cm)
  }

  // --- text settings ---

  set text(font: main-font, size: font-size, lang: "en")

  set par(leading: 1.2em, justify: true)

  set cite(style: "ieee")

  doc
}