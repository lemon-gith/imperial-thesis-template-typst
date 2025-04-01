#import "/layout/thesis_template.typ": thesis
#import "/metadata.typ": paper_title, author


#set document(title: paper_title, author: author)

#show: thesis.with(main-font: "New Computer Modern")

#include "/content/sections/introduction.typ"
#include "/content/sections/background.typ"
#include "/content/sections/related_work.typ"
#include "/content/sections/requirements_analysis.typ"
#include "/content/sections/system_design.typ"
#include "/content/sections/evaluation.typ"
#include "/content/sections/summary.typ"

