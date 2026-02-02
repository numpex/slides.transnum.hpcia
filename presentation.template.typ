// NumPEx Presentation Template for Typst
// Equivalent to presentation.template.tex

#import "numpex.typ": *

#show: numpex-theme.with(
  title: "A new presentation theme for NumPEx",
  short-title: "NumPEx Theme",
  author: "Christophe Prud'homme",
  short-author: "C. Prud'homme",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  institution: "Institute or miscellaneous information",
  aspect-ratio: "16-9",
)

// ============================================================================
// Title Slide
// ============================================================================

#title-slide(
  title: "A new presentation theme for NumPEx",
  subtitle: "This is a subtitle",
  author: "Christophe Prud'homme",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  institution: "Institute or miscellaneous information",
)

// ============================================================================
// Introduction
// ============================================================================

#slide(title: "NumPEx theme")[
  The NumPEx theme is a Beamer theme with minimal visual noise inspired by the

  #align(center)[
    #alert[#link("https://www.info.gouv.fr/marque-de-letat")[Charte graphique de l'etat Français]]
  ]

  Enable the theme by loading

  #v(-0.2em)
  #raw("\usetheme{numpex}", block: true, lang: "latex")
  #v(-0.2em)

  Note, that you have to have _Marianne_ font and XeTeX. Install it to enjoy this wonderful typography. You can find the font

  #align(center)[
    #alert[#link("https://www.systeme-de-design.gouv.fr/elements-d-interface/fondamentaux-de-l-identite-de-l-etat/typographie/")[here]]
  ]
]

#slide(title: "Sections")[
  Sections group slides of the same topic. Use the section-slide function:

  ```typst
  #section-slide("Elements")
  ```

  which creates a full-page section break with the NumPEx styling...
]

// ============================================================================
// Section: Elements
// ============================================================================

#section-slide("Elements")

#slide(title: "Typography")[
  The theme provides sensible defaults to _emphasize_
  text, #alert[accent] parts or show *bold* results.

  #v(1em)

  - Regular text appears in Marianne font (or fallback)
  - #alert[Alerted text] uses the French red color
  - _Emphasized text_ is italicized
  - *Bold text* for strong emphasis
]

#slide(title: "Lists")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 2em,

    [
      *Items*
      - Milk
      - Eggs
      - Potatoes
    ],

    [
      *Enumerations*
      + First,
      + Second and
      + Last.
    ],
  )
]

#slide(title: "Descriptions")[
  #set terms(separator: [ --- ])

  / PowerPoint: Meeh.
  / Beamer: Yeeeha.
  / Typst: Even better!
]

#slide(title: "Tables")[
  #figure(
    caption: [Largest cities in the world (source: Wikipedia)],
    table(
      columns: 2,
      align: (left, right),
      table.hline(stroke: 1.5pt),
      table.header([*City*], [*Population*]),
      table.hline(stroke: 0.5pt),
      [Mexico City], [20,116,842],
      [Shanghai], [19,210,000],
      [Peking], [15,796,450],
      [Istanbul], [14,160,467],
      table.hline(stroke: 1.5pt),
    ),
  )
]

#slide(title: "Blocks")[
  #block(title: "This is a block title")[
    Hello
  ]

  #example-block(title: "This is an example block")[
    Hello
  ]
]

#slide(title: "Math")[
  Euler's limit definition of $e$:

  $ e = lim_(n -> infinity) (1 + 1/n)^n $

  #v(1em)

  And the famous identity:

  $ e^(i pi) + 1 = 0 $
]

#slide(title: "Line plots")[
  #import "@preview/cetz:0.3.4": canvas, draw

  #align(center)[
    #canvas(length: 0.8cm, {
      import draw: *

      // Grid
      for x in range(0, 5) {
        line((x, -1), (x, 4), stroke: gray + 0.3pt)
      }
      for y in range(-1, 5) {
        line((0, y), (4, y), stroke: gray + 0.3pt)
      }

      // Axes
      line((-0.2, 0), (4.2, 0), mark: (end: ">"), stroke: black)
      line((0, -1.2), (0, 4.2), mark: (end: ">"), stroke: black)
      content((4.4, 0), $x$)
      content((0, 4.5), $f(x)$)

      // f(x) = x (red)
      line((0, 0), (3.5, 3.5), stroke: red)
      content((3.8, 3.5), $f(x) = x$, anchor: "west")

      // f(x) = sin(x) approximation (blue)
      let sin-points = ()
      for i in range(0, 40) {
        let x = i * 0.1
        let y = calc.sin(x)
        sin-points.push((x, y))
      }
      line(..sin-points, stroke: blue)
      content((4.2, 0.7), $f(x) = sin x$, anchor: "west")

      // f(x) = exp(x)/20 (orange)
      let exp-points = ()
      for i in range(0, 35) {
        let x = i * 0.1
        let y = 0.05 * calc.exp(x)
        exp-points.push((x, y))
      }
      line(..exp-points, stroke: orange)
      content((3.8, 1.7), $f(x) = 1/20 e^x$, anchor: "west")
    })
  ]
]

#slide(title: "Code")[
  I love Fortran!

  #v(0.5cm)

  ```fortran
  program pippo

    integer, parameter            :: m=10, n=5
    real(kind(1.d0)), allocatable :: a(:,:)

    allocate(a(m,n))      ! allocate the matrix

    call random_number(a) ! fill it up

    call do_something(a)  ! do something on it

    write(*,'("Hello world")')
    stop

  end program pippo
  ```
]

// ============================================================================
// Section: Conclusion
// ============================================================================

#section-slide("Conclusion")

#slide(title: "Summary")[
  Get the source of this theme and the demo presentation from

  #v(1em)

  #align(center)[
    #link("https://github.com/numpex/presentation.template/")
  ]

  #v(1em)

  *Typst advantages:*
  - Much faster compilation (sub-second)
  - Cleaner syntax
  - Built-in package manager
  - Hot reloading with `typst watch`
]

#plain-slide(title: "Questions?")
