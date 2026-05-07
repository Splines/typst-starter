#import "@preview/physica:0.9.5": *
#import "@preview/equate:0.3.2": *
#import "@preview/unify:0.7.1": *

#import "@preview/subpar:0.2.2"
#import "@preview/dashy-todo:0.0.2": *
#import "@preview/embiggen:0.0.1": *
#import "@preview/booktabs:0.0.4": *

#let color-main = rgb("#12346c")

// Optional text that is shown on the next chapter title page.
#let chapter-summary-state = state("thesis-chapter-summary", none)
#let chapter-summary(text) = chapter-summary-state.update(text)

#let show-todos = true
#let _dashy_todo = todo
#let todo(..args) = if show-todos { _dashy_todo(..args) } else { [] }

// https://github.com/typst/typst/issues/7424#issue-3645219121
#let sgn(x) = $op("sgn")(#x)$
#let argmin = $op("argmin", limits: #true)$
#let argmax = $op("argmax", limits: #true)$

// https://stackoverflow.com/a/77894083/
#let colorMath(x, color: rgb("#920576")) = text(fill: color)[$#x$]

// https://github.com/typst/typst/issues/2873#issuecomment-2138261314
#let pageref(label) = context [
  #let loc = locate(label)
  #let nums = counter(page).at(loc)
  page~#link(loc, numbering(loc.page-numbering(), ..nums))
]
