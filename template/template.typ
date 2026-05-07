#import "globals.typ": *
#import "util.typ": *
#import "@preview/hydra:0.6.2": hydra

#let thesis(
  // Cover page info
  title: [Title of the Thesis],
  author: (name: "Author", mail: "author@example.com", orcid: none),
  supervisor: "Supervisor's name",
  supervisor-first: "First Supervisor's name",
  supervisor-second: "Second Supervisor's name",
  date: datetime.today(),
  // Pages in-between
  abstract-en: none,
  keywords-en: none,
  abstract-de: none,
  keywords-de: none,
  // Institution
  university: "University Name",
  university-logo: image("assets/logo.svg", width: 110%),
  color-main: color-main,
  report-type: "Bachelor Thesis",
  organization: "Organization of Organizations",
  // License info
  license-name: "CC BY-SA 4.0",
  license-logo: image("assets/cc-by-sa.svg", width: 65pt),
  license-link: "https://creativecommons.org/licenses/by-sa/4.0/",
  body,
) = {
  //////////////////////////////////////////////////////////////////////////////
  // Basic document rules
  //////////////////////////////////////////////////////////////////////////////
  set document(title: title, author: author.name)
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3.5cm, left: 2.6cm, right: 2.6cm),
    number-align: right,
    numbering: "i",
    footer: none,
    header: context {
      show linebreak: none

      if calc.odd(here().page()) {
        // page shown on the right in book-binding
        align(right, emph(hydra(2)))
      } else {
        // page shown on the left in book-binding
        align(left, emph(hydra(1)))
      }
    },
  )

  //////////////////////////////////////////////////////////////////////////////
  // Style
  //////////////////////////////////////////////////////////////////////////////
  // Text setup
  set text(size: 12pt)
  set par(
    leading: 0.75em,
    spacing: 1.5em,
    justify: true,
    first-line-indent: 0pt,
  )

  // Enable heading-specific figure numbering and increase spacing.
  show figure: set block(spacing: 1.5em)
  show figure: set figure(gap: 1.0em)
  set figure(numbering: n => numbering("1.1", counter(heading).get().first(), n), gap: 1em)

  // Center caption, but left-align text inside
  // https://forum.typst.app/t/how-to-center-caption-but-left-align-the-text-inside/2561
  show figure.caption: it => {
    align(box(align(it, left)), center)
  }

  // show figure.where(
  //   kind: table,
  // ): set figure.caption(position: top)

  // https://forum.typst.app/t/how-can-i-make-a-figure-caption-left-aligned-or-centered-matching-the-alignment-to-the-number-of-lines-in-the-caption/7306/5?u=splines
  // show figure.caption: it => block({
  //   set align(left)
  //   strong({
  //     it.supplement
  //     [ ]
  //     context it.counter.display(it.numbering)
  //     it.separator
  //   })
  //   [ ]
  //   it.body
  // })

  set text(lang: "en")

  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // custom reference for equations
      link(it.target)[(#it)]
    } else {
      it
    }
  }

  show link: it => {
    if type(it.dest) != str {
      // set text(color)
      it
    } else {
      set text(color-main, font: "Inconsolata", size: 12pt * 0.95)
      if (it.dest.contains("orcid.org")) {
        it
      } else {
        underline(it)
      }
    }
  }

  show: equate.with(breakable: true, sub-numbering: false)
  // https://github.com/typst/typst/discussions/1917#discussioncomment-6703472
  set math.equation(
    numbering: "(1.1)",
    supplement: none,
  )
  // https://github.com/EpicEricEE/typst-equate/issues/11#issuecomment-2633709934
  // set math.equation(
  //   supplement: none,
  //   numbering: (..nums) => numbering("(1.1)", ..nums),
  // )

  // https://forum.typst.app/t/how-can-i-use-display-mode-for-in-line-math/1179/9
  // #show math.equation.where(block: false): it => math.display(it)

  //////////////////////////////////////////////////////////////////////////////
  // Headings
  //////////////////////////////////////////////////////////////////////////////
  set heading(numbering: "1.1")
  // disable numbering for 3rd level headings
  // https://stackoverflow.com/a/77488450/
  show heading.where(level: 3): it => [
    #block(it.body)
  ]

  // 📖 Chapter Title Page
  show heading.where(level: 1): it => {
    if it.numbering == none {
      it
    } else {
      // Ensure each chapter starts on a right-hand page
      // https://github.com/typst/typst/discussions/4337
      // https://github.com/typst/typst/discussions/3122#discussioncomment-13936086
      // pagebreak(to: "even")

      page(
        header: none,
        footer: none,
        numbering: none,
        margin: 0cm,
      )[
        // Left accent bar like on the cover page.
        // #place(
        //   left + top,
        //   rect(
        //     width: 1.2cm,
        //     height: 100%,
        //     fill: color,
        //   ),
        // )

        // Heidelberg logo in the chapter page background.
        #place(
          right + bottom,
          dx: 20%,
          dy: 12%,
          university-logo,
        )

        #pad(
          left: 2.6cm,
          right: 2.6cm,
          top: 3cm,
          bottom: 3.5cm,
          {
            v(3.5cm)

            line(length: 100%, stroke: (paint: color-main, thickness: 2pt, cap: "round"))

            // Chapter number and title on one line.
            grid(
              columns: (auto, 1fr),
              column-gutter: 1.2cm,
              align: (right + horizon, left + horizon),
              text(size: 120pt, weight: "bold", fill: color-main)[#counter(heading).display()],
              text(size: 34pt, weight: "semibold")[#it.body],
            )

            line(length: 100%, stroke: (paint: color-main, thickness: 2pt, cap: "round"))

            // Read intro inside an explicit context so .at() can resolve
            // the state value at the heading's document location.
            context {
              let intro = chapter-summary-state.at(it.location())
              if intro != none [
                #v(1.2cm)
                #set text(size: 12pt, weight: "regular")
                #box(fill: white.transparentize(40%), outset: 1em)[#intro]
              ]
            }
          },
        )
      ]

      // Reset state. Placed as content after the chapter page so the value
      // is still readable AT the heading location but cleared for subsequent chapters.
      chapter-summary-state.update(none)
    }
  }

  // Section headings (level 2)
  show heading.where(level: 2): it => {
    set text(size: 16pt, weight: "bold")
    block(
      above: 1.7em,
      below: 1.2em,
      {
        if it.numbering != none {
          counter(heading).display()
        }
        h(0.6em)
        it.body
      },
    )
  }

  //// Table of Contents //////////////////////////////////////////////////
  show outline: it => {
    show heading: pad.with(bottom: 1em)
    it
  }

  show outline.entry: it => {
    show linebreak: none
    it
  }

  // Level 1 outline entries are bold and there is no fill
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set block(above: 1.35em)
  show outline.entry.where(level: 1): set text(weight: "semibold")

  // Level 2 and 3 outline entries have a bigger gap and a dot fill
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): set outline.entry(fill: repeat(
    justify: true,
    gap: 0.5em,
  )[.])

  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => link(
    it.element.location(),
    it.indented(
      gap: 1em,
      it.prefix(),
      it.body() + box(width: 1fr, inset: (left: 5pt), it.fill) + box(width: 1.5em, align(right, it.page())),
    ),
  )

  //// Cover page /////////////////////////////////////////////////////////
  // adapted from https://typst.app/universe/package/bean-upm
  page(
    margin: 0cm,
    numbering: none,
  )[
    // Logo
    #place(
      right + bottom,
      dx: 20%,
      dy: 12%,
      university-logo,
    )

    // Colored bars
    #place(
      left + top,
      rect(
        width: 1.2cm,
        height: 100%,
        fill: color-main,
      ),
    )

    // Content
    #pad(
      left: 3cm,
      right: 2cm,
      top: 3cm,
      bottom: 3cm,
      {
        set text(size: 12pt)

        // Header info
        text(weight: "bold")[#upper(university)]
        linebreak()
        upper(report-type)
        linebreak()
        text[#upper(organization)]

        // Title
        v(3.5cm)
        set par(leading: 0.6em)
        box(fill: white.transparentize(40%), outset: 1em)[
          #text(size: 30pt, weight: "bold")[#title]
        ]

        // Author
        v(1cm)
        text(size: 18pt, weight: "bold")[#author.name]
        link("https://orcid.org/" + author.orcid)[
          #box(
            height: 10pt,
            move(image("assets/orcid.svg"), dx: 1pt),
          )
        ]
        linebreak()
        text(size: 13pt, weight: "light")[#author.email]

        v(1fr)

        // Bottom text
        set par(justify: false)
        set text(size: 14pt, weight: "regular")

        box(fill: white.transparentize(40%), outset: 1em)[
          #grid(
            columns: (auto, auto),
            column-gutter: 0.8em,
            row-gutter: 0.7em,
            align: (left, left),
            [*First supervisor*], [#supervisor-first],
            [*Second supervisor*], [#supervisor-second],
            [*Advisor*], [#supervisor],
          )
        ]

        v(10pt)
        [#emph(date.display("[month repr:long] [day padding:none], [year]"))]
      },
    )
  ]

  //// Metadata & License /////////////////////////////////////////////////
  page(
    header: none,
    numbering: none,
  )[
    #v(1fr)

    #set text(size: 11pt)
    #set par(justify: false, leading: 0.65em)
    #emph(title)

    #[
      #set par(spacing: 0.9em)

      *Written by:* #author.name
      #linebreak()
      ORCID: #link("https://orcid.org/" + author.orcid)[#author.orcid] | Email: #author.email | #author.homepage

      *First supervisor:* #supervisor-first
      #linebreak()
      *Second supervisor:* #supervisor-second
      #linebreak()
      *Advisor:* #supervisor

      #report-type | #date.display("[month repr:long] [day padding:none], [year]")
    ]

    *#university* | #organization

    #v(1.5em)
    #line(length: 100%, stroke: 0.5pt)
    #v(1em)

    // License text and logo
    #grid(
      columns: (1fr, auto),
      column-gutter: 4em,
      align: (left, right),
      [
        #set par(justify: true)
        This work is licensed under #link(license-link)[#license-name]. To view a copy of this license, visit #link(license-link)[#license-link]
      ],
      if license-logo != none {
        link(license-link)[#license-logo]
      },
    )

    The logo/seal is property of #university and exempt from this license. Its usage in the background of this Thesis' title page was generously granted by #todo[finish]

    This thesis was written using #strong(link("http://github.com/typst/typst/")[Typst]), a modern typesetting system with an open-source compiler.

    #v(1.5em)
    #line(length: 100%, stroke: 0.5pt)
    #v(1em)

    *Declaration*

    GitHub Copilot \[AI chatbot powered by Large Language Models (LLMs), integrated into VSCode\] was used to assist with writing (formulation and wording) and coding. Any output by LLMs was critically reviewed and edited by the author, and all final decisions regarding content and phrasing were made by the author. The author is solely responsible for the content of this thesis.

    I hereby declare that I have written this thesis independently and have not used any sources or aids other than those specified.

    Ich versichere, dass ich diese Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.

    Place#todo[insert place],
    #date.display("[month repr:long] [day padding:none], [year]")

    #todo[Insert your signature]

    _ #author.name _
  ]


  //// Abstract ///////////////////////////////////////////////////////////
  page[
    #align(center + horizon)[
      #text[*Abstract*]\ \
      #align(left, abstract-en)
    ]

    #if keywords-en != none [
      #v(1em)
      *Keywords:* #keywords-en
    ]
  ]

  if abstract-de != none {
    page[
      #align(center + horizon)[
        #text[*Zusammenfassung*]\ \
        #align(left, abstract-de)
      ]

      #if keywords-de != none [
        #v(1em)
        *Keywords:* #keywords-de
      ]
    ]
  }


  //// Body ///////////////////////////////////////////////////////////////
  pagebreak(to: "odd")
  body
}
