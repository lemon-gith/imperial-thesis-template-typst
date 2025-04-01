#import "@preview/minitoc:0.1.0": *

#import "/layout/thesis_template.typ": *
#import "/metadata.typ": *

#import "/content/preamble/acronyms.typ": acronyms
#let abstract_body = include "/content/preamble/abstract.typ"
#let acknowledgement_body = include "/content/preamble/acknowledgement.typ"
#let declarations_body = include "/content/preamble/declarations.typ"


#set document(title: paper_title, author: author)

#show: thesis.with(
  title: paper_title,
  subtitle: subtitle,
  degree_type: degree_type,
  degree_level: degree_level,
  program: program,
  report_level: report_level,
  supervisors: supervisors,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate,
  abstract: abstract_body,
  acknowledgement: acknowledgement_body,
  declarations: declarations_body,
  acronyms: acronyms
)

#include "/content/sections/introduction.typ"
#include "/content/sections/background.typ"
#include "/content/sections/related_work.typ"
#include "/content/sections/requirements_analysis.typ"
#include "/content/sections/system_design.typ"
#include "/content/sections/evaluation.typ"
#include "/content/sections/summary.typ"

