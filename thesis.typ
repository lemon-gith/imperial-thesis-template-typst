#import "@preview/minitoc:0.1.0": *

#import "/layout/thesis_template.typ": *
#import "/metadata.typ": *

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
  abstract_en: include "/content/abstract_en.typ",
  acknowledgement: include "/content/acknowledgement.typ",
  transparency_ai_tools: include "/content/transparency_ai_tools.typ",
)

#set page(columns: 2)

#include "/content/introduction.typ"
#include "/content/background.typ"
#include "/content/related_work.typ"
#include "/content/requirements_analysis.typ"
#include "/content/system_design.typ"
#include "/content/evaluation.typ"
#include "/content/summary.typ"

