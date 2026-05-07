// Global imports

#import "@preview/physica:0.9.5": *
#import "@preview/delimitizer:0.1.0": *
#import "@preview/dashy-todo:0.0.2": *
#import "@preview/equate:0.3.2": *

#let color-main = rgb("#12346c")

// Optional text that is shown on the next chapter title page.
#let chapter-summary-state = state("thesis-chapter-summary", none)
#let chapter-summary(text) = chapter-summary-state.update(text)

#let show-todos = true
#let _dashy_todo = todo
#let todo(..args) = if show-todos { _dashy_todo(..args) } else { [] }

#import "@preview/mannot:0.2.2": markrect
#import "@preview/unify:0.7.1": *
#import "@preview/cetz:0.3.3": canvas, draw
#import "@preview/cetz-plot:0.1.1": chart, plot
#import "@preview/embiggen:0.0.1": *
#import "@preview/booktabs:0.0.4": *
// alternative to subpar:
// https://github.com/patrick-kidger/patstdlib/blob/main/src/figure.typ
#import "@preview/subpar:0.2.2"
#import "@preview/nth:1.0.1": *
#import "@preview/chemformula:0.1.2": ch

// https://github.com/typst/typst/issues/7424#issue-3645219121
#let sgn(x) = $op("sgn")(#x)$
#let argmin = $op("argmin", limits: #true)$
#let argmax = $op("argmax", limits: #true)$

// Custom boxes around equation
#let boxed(content) = markrect(content, padding: .3em, radius: 5%)

// https://stackoverflow.com/a/77894083/
#let colMath(x, color) = text(fill: color)[$#x$]

#let theorem_fill = rgb("#f0f0f8")
#let theorem_stroke = rgb("#1f1f50") + 1pt
#let counter_key = "theorem-like"

// Theorems
#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#theorem[Euclid's Theorem][
  There are infinitely many prime numbers.
] <thm:euclid>

#theorem-box(outlined: false)[Theorem without numbering][
  This theorem is not numbered.
]

// https://github.com/typst/typst/issues/2873#issuecomment-2138261314
#let pageref(label) = context {
  let loc = locate(label)
  let nums = counter(page).at(loc)
  link(loc, numbering(loc.page-numbering(), ..nums))
}
