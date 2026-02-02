// NumPEx Poster Template for Typst
// Equivalent to poster.template.tex
// A0 format (841mm x 1189mm)

#import "numpex.typ": accent-teal, alert, nblue, ngreen, npurple, nred

// ============================================================================
// Poster Configuration
// ============================================================================

#let poster-title = "A Poster Theme for NumPEx"
#let poster-author = "Alfredo Buttari, Christophe Prud'homme"
#let poster-institution = "Institute or Miscellaneous Information"
#let poster-date = datetime.today().display("[month repr:long] [day], [year]")

// ============================================================================
// Page Setup
// ============================================================================

#set page(
  paper: "a0",
  margin: 0pt,
  background: image("images/NumPEx_1.pdf", width: 100%, height: 100%),
)

#set text(
  font: ("Marianne", "Inter", "Helvetica Neue", "Arial"),
  size: 24pt,
)

#set par(justify: true)

// ============================================================================
// Poster Block Style
// ============================================================================

#let poster-block(title: none, body) = {
  box(
    width: 100%,
    fill: white,
    radius: 5pt,
    stroke: none,
    inset: 0pt,
  )[
    // Title
    #if title != none [
      #box(
        width: 100%,
        fill: npurple.lighten(85%),
        radius: (top: 5pt),
        inset: 12pt,
      )[
        #set text(weight: "bold", size: 28pt)
        #title
      ]
    ]

    // Body
    #box(
      width: 100%,
      fill: white,
      radius: if title != none { (bottom: 5pt) } else { 5pt },
      inset: 15pt,
    )[
      #body
    ]
  ]
}

#let poster-example-block(title: none, body) = {
  box(
    width: 100%,
    fill: white,
    radius: 5pt,
    stroke: none,
  )[
    // Title
    #if title != none [
      #box(
        width: 100%,
        fill: accent-teal.lighten(80%),
        radius: (top: 5pt),
        inset: 12pt,
      )[
        #set text(weight: "bold", size: 28pt)
        #title
      ]
    ]

    // Body
    #box(
      width: 100%,
      fill: white,
      radius: if title != none { (bottom: 5pt) } else { 5pt },
      inset: 15pt,
    )[
      #body
    ]
  ]
}

// ============================================================================
// Header (5cm tall)
// ============================================================================

#place(top)[
  #box(
    width: 100%,
    height: 5cm,
    fill: white,
  )[
    // Left logos (RF + France 2030)
    #place(top + left, dx: 0.5cm, dy: 0.5cm)[
      #image("images/rf.png", height: 3cm)
      #h(0.3cm)
      #image("images/f2030.png", height: 3cm)
    ]

    // Right logos (CEA, INRIA, CNRS)
    #place(top + right, dx: -0.5cm, dy: 0.5cm)[
      #image("images/cea.jpg", height: 3cm)
      #h(0.3cm)
      #image("images/inria.png", height: 3cm)
      #h(0.3cm)
      #image("images/cnrs.png", height: 3cm)
    ]

    // Title (centered)
    #place(bottom + center, dy: -0.5cm)[
      #set align(center)
      #text(size: 60pt, weight: "bold", poster-title)
      #v(0.3cm)
      #text(size: 36pt, poster-author)
    ]
  ]
]

// ============================================================================
// Footer (2cm tall)
// ============================================================================

#place(bottom)[
  #box(
    width: 100%,
    height: 2cm,
    fill: white,
  )[
    // Left logos
    #place(bottom + left, dx: 0.5cm, dy: -0.25cm)[
      #image("images/rf.png", height: 1.5cm)
      #h(0.2cm)
      #image("images/f2030.png", height: 1.5cm)
    ]

    // Right logos
    #place(bottom + right, dx: -0.5cm, dy: -0.25cm)[
      #image("images/cea.jpg", height: 1.5cm)
      #h(0.2cm)
      #image("images/inria.png", height: 1.5cm)
      #h(0.2cm)
      #image("images/cnrs.png", height: 1.5cm)
    ]

    // Center text
    #place(center + horizon)[
      #text(size: 20pt)[#poster-institution #h(2em) #poster-date]
    ]
  ]
]

// ============================================================================
// Main Content Area
// ============================================================================

#place(top + center, dy: 5.5cm)[
  #box(width: 90%, height: 100cm)[
    #set text(size: 22pt)

    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1.5cm,

      // ========================================
      // Column 1
      // ========================================
      [
        #poster-block(title: "Theme Overview")[
          The NumPEx theme is a Typst presentation and poster theme with minimal visual noise inspired by the French state graphic charter.

          #v(0.3cm)

          *Enable the theme by importing:*

          ```typst
          #import "numpex.typ": *
          ```

          #v(0.3cm)

          See the French state graphic guidelines:

          #align(center)[
            #alert[#link("https://www.info.gouv.fr/marque-de-letat")[Charte graphique de l'État Français]]
          ]
        ]

        #v(0.5cm)

        #poster-block(title: "Sections & Typography")[
          The theme provides sensible defaults for:

          - _Emphasis_ on key text
          - #alert[Accents] on important parts
          - *Bold* for results

          #v(0.5cm)

          Typography uses the official Marianne font from the French government design system, with fallbacks for systems where it's not installed.
        ]
      ],

      // ========================================
      // Column 2
      // ========================================
      [
        #poster-block(title: "Lists, Descriptions & Tables")[
          *Lists:*
          - Milk, Eggs, Potatoes

          *Enumerations:*
          + First
          + Second
          + Last

          *Descriptions:*
          / PowerPoint: Meeh.
          / Beamer: Yeeeha.
          / Typst: Even better!
        ]

        #v(0.5cm)

        #poster-block(title: "Tables")[
          #figure(
            caption: [Largest cities in the world],
            table(
              columns: 2,
              align: (left, right),
              stroke: none,
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
      ],

      // ========================================
      // Column 3
      // ========================================
      [
        #poster-block(title: "Blocks & Math")[
          *Mathematics:*

          $ e = lim_(n -> infinity) (1 + 1/n)^n $

          #v(0.5cm)

          The famous Euler identity:

          $ e^(i pi) + 1 = 0 $
        ]

        #v(0.5cm)

        #poster-example-block(title: "Example Block")[
          This is an example block with teal styling.

          Use it to highlight examples, tips, or supplementary information.
        ]

        #v(0.5cm)

        #poster-block(title: "Code Example")[
          ```fortran
          program pippo
            integer, parameter :: m=10, n=5
            real(kind(1.d0)), allocatable :: a(:,:)
            allocate(a(m,n))
            call random_number(a)
            call do_something(a)
            write(*,'("Hello world")')
            stop
          end program pippo
          ```
        ]

        #v(0.5cm)

        #poster-block(title: "Conclusion")[
          Get the source of this theme from:

          #align(center)[
            #text(size: 18pt)[
              #link("https://github.com/numpex/presentation.template/")
            ]
          ]

          #v(0.5cm)

          *Typst advantages:*
          - Sub-second compilation
          - Cleaner syntax
          - Hot reloading
        ]
      ],
    )
  ]
]
