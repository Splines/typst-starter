#import "../template/globals.typ": *

#chapter-summary[
  #lorem(50)
]
= TODO

== Welcome

- typst docs & getting started guide
- Typst Universe
- link to @cite:typst paper
- guide when coming from LaTeX
- good luck & have fun

== Building Blocks

Here is an overview of sum of the fundamental building blocks of your thesis. Use inline math to write formulas like $N/(N+1)$, $E = colorMath(m) colorMath(c, color: #blue)^2$ or $qty("5.25e-3", "eV")$. Add another space and you get a display formula like Gauss' formula for the sum of the first $n$ integers:
$
  sum_(k=1)^n k = (n (n+1)) / 2
$<eq:gauss>

Or the fundamental theorem of calculus:
$
  integral_a^b f(x) dif x = F(b) - F(a)
$
where $f$ is the derivative of $F$.

We can also reference @eq:gauss for use later on. It is located on #pageref(<eq:gauss>). @fig:butterfly shows a butterfly, and @tab:temperatures presents the most important results.

#figure(
  image("assets/butterfly.svg", width: 30%),
  caption: [A butterfly. Taken from @cite:butterfly. Prefer vector graphics over raster images whenever possible as they scale without loss of quality (you can zoom in as much as you like and it will still look crisp). And their file size is typically a lot smaller than raster images],
) <fig:butterfly>

#let temperature_results = table(
  columns: 3,
  align: (left, center, center),
  toprule(),
  table.header(
    [Evaluated at], [*Mean Total Totality Error* \ $Delta T$ \[#unit("kJ")\]], [*Mean Meaner* \ $norm(Delta xi)_2$]
  ),
  midrule(),
  //
  [Head], [$0.314$], [$0.015$],
  midrule(),
  //
  [Left Arm], [$2.270$], [$0.025$],
  [Right Arm], [$2.151$], [$0.011$],
  [Stomach], [$2.132$], [$0.52$],
  //
  bottomrule(),
)

#figure(
  temperature_results,
  caption: [Very important results. The table is styled using the `booktabs` package.],
) <tab:temperatures>

