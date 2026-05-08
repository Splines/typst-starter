#import "../template/globals.typ": *
#import "@preview/metalogo:1.2.0": LaTeX


#chapter-summary[
  Here, we introduce everything you need to know to get started writing your thesis with this template: from how it is structured, to useful links to the documentation as well as basic examples for fundamental building blocks.
]
= Introduction

== Welcome

Welcome to your thesis! This is _your_ document and _your_ place to put together your ideas and where all your results come together. On my #link("https://splines.me/blog/2026/bachelor-thesis-typst")[Blog], I've written about how I made use of Typst for my Physics Bachelor thesis. This template repository was extracted from that thesis to help get you started more quickly and easily.

Usually, you would make use of one of the many templates on #link("https://typst.app/universe/search/?kind=templates")[Typst Universe]. The downside is that they don't tell you how to structure a big document like a thesis. And they don't allow you to make any customizations to the template afterwards.

So instead, what you get here is a pre-populated document structure with its own template in the `template/` folder. This way, we keep the document content itself separate from layout and typographic choices, while still giving you full control over every stylistic aspect. In fact, you could even just put the source code for any template from the Typst Universe in the `template/` folder and use that.


== Template & Global imports

The main file you want to modify for stylistic choices is the `template/template.typ` file. Furthermore -- as there are no #link("https://github.com/typst/typst/issues/595")[global imports] in Typst -- you want to add this to every file in the `content/` folder:

```typ
#import "../template/globals.typ": *
```

In that `globals.typ` file, put any imports you want to use everywhere, e.g. I put the #link("https://typst.app/universe/package/physica")[physica] package there.

The template is being made use of in the `main.typ` file:

```typ
#show: thesis.with(
  title: "Typst-Starter: \nLet's get started with that Thesis",
  // and so on
)
```

If you want to make your own modifications to the template (which you will certainly have to), I recommend you do read #link("https://typst.app/docs/tutorial/making-a-template/")[Making a Template].


== Getting started & helpful resources

In case you're coming from #LaTeX, you will probably enjoy the #link("https://typst.app/docs/guides/for-latex-users/")[Guide for #LaTeX users]. I also highly recommend to work through the great #link("https://typst.app/docs/tutorial/")[Typst Tutorial], it introduces you to the basics and is nice to follow. For more advanced things, you'll find everything either in the #link("https://typst.app/docs/reference/")[References], the #link("https://forum.typst.app/")[Typst Forum] (use the search there), or in the #link("http://github.com/typst/typst/issues")[Github issues]. Also check out @cite:typst, a paper about Typst, written in Typst 😅


== Setup

The setup should be described in the Typst-Starter Readme of this project. Essentially, use the #link("https://myriad-dreamin.github.io/tinymist/")[Tinymist Typst Language Server], e.g. via #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[the Tinymist Typst VSCode extension]. For VSCode, I've already set up some defaults for the editor and spell checking in the `.vscode/settings.json`. I've also added some recommended extensions. Finally, as always, remember to commit frequently via Git to not loose your precious document.


== Assets

Place your assets in the `assets/` folder and import them as shown for @fig:butterfly. Always prefer vector graphics over raster images since vector graphics scale without loss of quality (you can zoom in as much as you like and they will still look crisp). And their file size is typically a lot smaller than raster images. If you want to edit vector graphics, there are online tools like #link("https://www.vectorpea.com/")[Vectorpea]. I personally use #link("https://www.affinity.studio/de_de")[Affinity] (coming from Adobe Illustrator & Photoshop).

#figure(
  image("../assets/butterfly.svg", width: 30%),
  caption: [A butterfly. Taken from @cite:butterfly.],
) <fig:butterfly>

Furthermore, choose a colorblind-friendly color palette for your plots. There are plenty out there on the Internet, even simulators where you can test your color choices. It'd be a pity if some people couldn't read your plots. For how to use Matplotlib together with Typst, I wrote a dedicated section #link("https://splines.me/blog/2026/bachelor-thesis-typst#plots-matplotlib-and-typst")[in my blog post].


== More building blocks

More fundamental building blocks are explained in the #link("https://typst.app/docs/tutorial/")[Typst Tutorial]. Here is a very brief overview. Use inline math to write formulas like $cal(A)_"ext" [Q]$, $N/(N+1)$, $E = colorMath(m) colorMath(c, color: #blue)^2$ or $qty("5.25e-3", "eV")$. Add another space and you get a display formula like Gauss' formula for the sum of the first $n$ integers:
$
  sum_(k=1)^n k = (n (n+1)) / 2
$<eq:gauss>

Or the fundamental theorem of calculus:
$
  integral_a^b f(x) dif x = F(b) - F(a)
$
where $f$ is the derivative of $F$. Keep your punctuation consistent, I usually prefer not to include points or commas after formulas typeset in display mode.

We can also reference @eq:gauss for use later on. Or get to know that it is located on #pageref(<eq:gauss>). @fig:butterfly shows a butterfly, and @tab:temperatures presents the most important results.

#let temperature_results = table(
  columns: 3,
  align: (left, center, center),
  toprule(),
  table.header(
    [Evaluated at], [*Mean Total Totality Error* \ $Delta T$ \[#unit("kJ")\]], [*Mean Meaner* \ $norm(Delta xi)_2$]
  ),
  midrule(),
  //
  [Red], [$0.314$], [$0.015$],
  midrule(),
  //
  [Green], [$2.270$], [$0.025$],
  [Blue], [$2.151$], [$0.011$],
  [Yellow], [$2.132$], [$0.52$],
  //
  bottomrule(),
)

#figure(
  temperature_results,
  caption: [Very important results. The table is styled using the `booktabs` package.],
) <tab:temperatures>


== Bibliography

For the bibliography, see the #link("https://typst.app/docs/reference/model/bibliography/")[docs]. Basically, you can continue to use BibTex `.bib` files. Or try out the new #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md")[Hayagriva YAML File Format] (used here). See the `literature.yml` file. You probably want to bookmark #link("https://jonasloos.github.io/bibtex-to-hayagriva-webapp/")[this nifty converter] since journals online don't allow you to export to Hayagriva (yet).


== Have Fun

Last but not least: have fun with your thesis. It's a long project and a daunting task, so one shouldn't forget to also enjoy it along the way. If you need some comedy, music and want to fall in love with humanity again, I recommend to watch #link("https://youtu.be/QU1DdnQ7_zU")[Jacob Collier's Full Masterclass] at some point. Finally, if you like this template repository, feel free to star it #link("https://github.com/splines/typst-starter")[on GitHub].
