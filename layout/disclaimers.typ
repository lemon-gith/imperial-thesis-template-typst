#import "/metadata.typ": location, submissionDate, author


#let disclaimers_layout(disclaimer_sections: (), include_sign: true) = [
  = Disclaimers

  #for disclaimer in disclaimer_sections {
    disclaimer
  }

  #if not include_sign {
    return
  }

  #v(1cm)
  #grid(
    columns: 2,
    gutter: 1fr,
    [
      #location, #submissionDate.display("[day].[month].[year]")
    ], author
  )
]