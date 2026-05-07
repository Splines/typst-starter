#import "template/template.typ": *

// print: https://www.znf.uni-heidelberg.de/de/services/kompletter-service-bei-printmedien/service-fuer-studierende

#show: thesis.with(
  title: "Typst-Starter: \nLet's get started with that Thesis",
  author: (
    name: "Typst Lover",
    email: [info\@example.com],
    homepage: [#link("https://example.com")],
    orcid: "0000-0000-0000-0000",
  ),
  supervisor: "Your Direct Advisor",
  supervisor-first: "Prof. Dr. First Supervisor",
  supervisor-second: "Prof. Dr. Second Supervisor",
  date: datetime(year: 2026, month: 05, day: 07),

  university: "Typst University",
  report-type: "Bachelor Thesis in Typography",

  abstract-en: include "content/abstract.typ",
  abstract-de: include "content/abstract-de.typ",
)

#set cite(style: "springer-basic")
#show: booktabs-default-table-style

#outline(depth: 2)

// Content
#show: arabic-numbering.with(reset: true, alternate: true)
#include "content/todo.typ"

// Bibliography
#show bibliography: set heading(numbering: "1")
#bibliography("literature.yml")

// Appendix
#set heading(numbering: "A", supplement: [Appendix])
#counter(heading).update(0)
= Appendix

#set heading(numbering: "A.1", supplement: [Appendix])
#include "content/appendix/a.typ"
