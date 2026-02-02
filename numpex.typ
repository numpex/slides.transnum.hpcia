// NumPEx Typst Presentation Theme
// Based on the French State Graphic Charter (Charte graphique de l'État Français)
// Copyright 2024-2025 NumPEx Project
// Licensed under MIT License

// Slide helper (Typst-native): create one page per slide.
// We avoid depending on external presentation frameworks for now so the
// template works out-of-the-box.
// Using pagebreak(weak: true) ensures no blank page at the start while
// still separating subsequent slides.
#let polylux-slide(body) = {
  pagebreak(weak: true)
  body
}

// ============================================================================
// Color Definitions (French State Colors)
// ============================================================================

#let nblue = rgb("#000091")    // French blue - primary structural color
#let nred = rgb("#E1000F")     // French red - alerts and accents
#let ngreen = rgb("#467248")   // Forest green - code strings
#let npurple = rgb("#6E445A")  // Purple - secondary accent
#let accent-teal = rgb("#008B8B")  // Teal - example blocks

#let gray30 = rgb(30%, 30%, 30%)
#let gray60 = rgb(60%, 60%, 60%)
#let gray80 = rgb(85%, 85%, 85%)

// ============================================================================
// Font Configuration
// ============================================================================

#let marianne-regular = "Marianne"
#let marianne-light = "Marianne Light"
#let marianne-bold = "Marianne Bold"
#let marianne-medium = "Marianne Medium"

// Note: Typst selects weights (light/regular/bold/...) within a family.
// When compiling with `--font-path fonts/Marianne/desktop`, the family is
// typically exposed as "Marianne".
// Roboto Mono is provided in this repo under fonts/Roboto/static.

// Font fallbacks for systems without Marianne
#let sans-fonts = ("Marianne", "Helvetica Neue", "Arial")
#let mono-fonts = ("Roboto Mono", "Fira Code", "Consolas")

// ============================================================================
// Slide Dimensions and Margins
// ============================================================================

#let slide-width = 160mm   // Beamer 16:9 dimensions
#let slide-height = 90mm

// Beamer theme uses 0.06\paperwidth for left/right text margins.
// Here we compute it from the fixed slide width (160mm).
#let margin-x = 0.06 * slide-width
// Beamer theme sets \leftmargini = 0.6 * normalmargin.
#let list-indent = 0.6 * margin-x

// Beamer footline uses ht=3ex, dp=3ex (≈ 6ex total).
// With 10pt base font: 1ex ≈ 4.3pt, so 6ex ≈ 25.8pt ≈ 0.9cm
#let footline-height = 0.9cm

// ============================================================================
// Theme State
// ============================================================================

#let numpex-config = state("numpex-config", (
  title: none,
  short-title: none,
  author: none,
  short-author: none,
  date: none,
  institution: none,
))

// ============================================================================
// Utility Functions
// ============================================================================

#let numpex-logo(height: 1cm, name) = {
  image("images/" + name, height: height)
}

// ============================================================================
// Title Slide
// ============================================================================

#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  institution: none,
) = {
  // Store metadata for footline
  numpex-config.update(cfg => {
    cfg.title = title
    cfg.author = author
    cfg.date = date
    cfg.institution = institution
    cfg
  })

  polylux-slide[
    #set page(margin: 0pt)

    // White header bar at top
    #place(top)[
      #box(width: 100%, height: 1.5cm, fill: white)
    ]

    // Background image (below header)
    #place(top, dy: 1.5cm)[
      #image("images/back1.jpg", width: 100%)
    ]

    // Top left: République Française logo (on white header)
    #place(top + left, dx: 0.5cm, dy: 0.1cm)[
      #image("images/rf.png", height: 1.3cm)
    ]

    // Top right: Partner logos (CEA, CNRS, INRIA) (on white header)
    #place(top + right, dx: -0.3cm, dy: 0.15cm)[
      #stack(
        dir: ltr,
        spacing: 0.2cm,
        image("images/cea.jpg", height: 1cm),
        image("images/cnrs.png", height: 1cm),
        image("images/inria.png", height: 0.9cm),
      )
    ]

    // Left: France 2030 logo (centered vertically in background area)
    #place(left + horizon, dx: 0.8cm, dy: 0.5cm)[
      #image("images/f2030_white.png", height: 2cm)
    ]

    // Right: Title block
    #place(right + horizon, dx: -0.5cm, dy: 0.5cm)[
      #box(width: 60%)[
        #set align(left)
        #set text(fill: white)

        #if title != none [
          #text(size: 18pt, weight: "regular", title)
          #v(0.4em)
        ]

        #if subtitle != none [
          #text(size: 10pt, weight: "light", subtitle)
          #v(0.4em)
        ]

        #if author != none [
          #text(size: 8pt, weight: "light", author)
          #v(0.2em)
        ]

        #if date != none [
          #text(size: 8pt, weight: "light", date)
        ]

        #if institution != none [
          #v(1.5mm)
          #text(size: 8pt, weight: "light", institution)
        ]
      ]
    ]
  ]
}

// ============================================================================
// Section Slide
// ============================================================================

#let section-slide(title) = {
  polylux-slide[
    #set page(margin: 0pt)

    // White header bar at top
    #place(top)[
      #box(width: 100%, height: 1.5cm, fill: white)
    ]

    // Top left: RF + France 2030 logos (on white header)
    #place(top + left, dx: 0.2cm, dy: 0.1cm)[
      #stack(dir: ltr, spacing: 0.15cm, image("images/rf.png", height: 1.3cm), image("images/f2030.png", height: 1.3cm))
    ]

    // Top right: Partner logos (on white header)
    #place(top + right, dx: -0.3cm, dy: 0.15cm)[
      #stack(
        dir: ltr,
        spacing: 0.2cm,
        image("images/cea.jpg", height: 1cm),
        image("images/cnrs.png", height: 1cm),
        image("images/inria.png", height: 0.9cm),
      )
    ]

    // Background image (below header)
    #place(top, dy: 1.5cm)[
      #image("images/back2.jpg", width: 100%)
    ]

    // Section title (centered in background area)
    #place(center + horizon, dy: 0.5cm)[
      #set text(fill: white, size: 22pt, weight: "regular")
      #title
    ]
  ]
}

// ============================================================================
// Footline
// ============================================================================

#let numpex-footline = context {
  let cfg = numpex-config.get()
  let current = here().page()

  box(width: 100%, height: footline-height)[
    #set align(horizon)
    #set text(size: 7pt, fill: nblue)

    #grid(
      columns: (22.22%, 55.56%, 16.67%, 5.55%),
      rows: (footline-height,),
      align: (center + horizon, center + horizon, right + horizon, center + horizon),

      // Logos (horizontal stack) - matching Beamer heights
      stack(
        dir: ltr,
        spacing: 0.15cm,
        image("images/cea.jpg", height: 0.6cm),
        image("images/cnrs.png", height: 0.6cm),
        image("images/inria.png", height: 0.5cm),
      ),

      // Title (no wrap)
      box(clip: true)[#if cfg.title != none { cfg.title } else { "" }],

      // Author (no wrap)
      box(clip: true)[#if cfg.author != none { cfg.author } else { "" }],

      // Page number
      str(current),
    )
  ]
}

// ============================================================================
// Regular Slide
// ============================================================================

#let slide(title: none, body) = {
  polylux-slide[
    // Footer should span the full slide width (like Beamer).
    // We'll implement text margins inside the slide body instead.
    #set page(
      margin: (top: 0pt, bottom: footline-height, x: 0pt),
      footer: numpex-footline,
    )

    // Frame title: full-width bar with compact padding.
    #if title != none [
      #box(width: 100%, inset: 0.25cm)[
        #set text(size: 12pt, fill: nblue, weight: "regular")
        #title
      ]
    ]

    #v(0.2cm)

    // Body content with Beamer-like left/right margins.
    // Using a grid makes `width: 100%` resolve to the *text column* width.
    #grid(
      columns: (margin-x, 1fr, margin-x),
      gutter: 0pt,
      [], body, [],
    )
  ]
}

// ============================================================================
// Plain Slide (for questions, etc.)
// ============================================================================

#let plain-slide(title: none, body: none) = {
  polylux-slide[
    #set page(
      fill: white,
      margin: (top: 0pt, bottom: footline-height, x: 0pt),
      footer: numpex-footline,
    )

    #place(center + horizon)[
      #set text(size: 18pt, fill: nblue, weight: "bold")
      #if title != none { title } else { body }
    ]
  ]
}

// ============================================================================
// Block Environments
// ============================================================================

#let block(title: none, body) = {
  v(0.5em)
  box(width: 100%)[
    // Title bar
    #if title != none [
      #box(
        width: 100%,
        fill: nblue,
        inset: 0.35em,
      )[
        #set text(fill: white, weight: "regular", size: 11pt)
        #title
      ]
    ]

    // Body
    #box(
      width: 100%,
      fill: white,
      inset: 0.35em,
    )[
      #body
    ]

    // Bottom bar
    #box(
      width: 100%,
      fill: nblue,
      height: 0.05cm,
    )[]
  ]
  v(0.5em)
}

#let example-block(title: none, body) = {
  v(0.5em)
  box(width: 100%)[
    // Title bar
    #if title != none [
      #box(
        width: 100%,
        fill: accent-teal.darken(30%),
        inset: 0.35em,
      )[
        #set text(fill: white, weight: "regular", size: 11pt)
        #title
      ]
    ]

    // Body
    #box(
      width: 100%,
      fill: accent-teal.lighten(95%),
      inset: 0.35em,
    )[
      #body
    ]

    // Bottom bar
    #box(
      width: 100%,
      fill: accent-teal.darken(30%),
      height: 0.05cm,
    )[]
  ]
  v(0.5em)
}

#let alert-block(title: none, body) = {
  v(0.5em)
  box(width: 100%)[
    // Title bar
    #if title != none [
      #box(
        width: 100%,
        fill: nred,
        inset: 0.35em,
      )[
        #set text(fill: white, weight: "regular", size: 11pt)
        #title
      ]
    ]

    // Body
    #box(
      width: 100%,
      fill: nred.lighten(95%),
      inset: 0.35em,
    )[
      #body
    ]

    // Bottom bar
    #box(
      width: 100%,
      fill: nred,
      height: 0.05cm,
    )[]
  ]
  v(0.5em)
}

// ============================================================================
// Text Styling
// ============================================================================

#let alert(body) = text(fill: nred, body)
#let emph-text(body) = emph(body)

// ============================================================================
// Code Styling
// ============================================================================

#let code-block(lang: none, body) = {
  set text(font: mono-fonts, size: 9pt)

  box(
    width: 100%,
    fill: black.lighten(97%),
    stroke: nblue,
    inset: 1em,
    radius: 0pt,
  )[
    #if lang != none {
      raw(body, lang: lang, block: true)
    } else {
      raw(body, block: true)
    }
  ]
}

// ============================================================================
// Theme Initialization
// ============================================================================

#let numpex-theme(
  aspect-ratio: "16-9",
  title: none,
  short-title: none,
  author: none,
  short-author: none,
  date: none,
  institution: none,
  body,
) = {
  // Store configuration
  numpex-config.update(cfg => {
    cfg.title = if short-title != none { short-title } else { title }
    cfg.author = if short-author != none { short-author } else { author }
    cfg.date = date
    cfg.institution = institution
    cfg
  })

  set document(
    title: title,
    author: author,
  )

  // Use Beamer's exact dimensions (160mm x 90mm) instead of Typst's preset
  // This ensures the same aspect ratio and proportions as LaTeX Beamer
  set page(
    width: 160mm,
    height: 90mm,
    margin: 0pt,
  )

  // Font settings (matching Beamer 10pt base)
  set text(
    font: sans-fonts,
    size: 10pt,
    fill: black.lighten(3%),
  )

  // Paragraph settings
  set par(justify: false)

  // List styling (circular bullets)
  set list(
    marker: ([•], [◦], [•]),
    indent: list-indent,
  )

  // Enumeration styling
  set enum(indent: list-indent)

  // Heading styling
  show heading.where(level: 1): set text(fill: nblue, size: 14pt, weight: "regular")
  show heading.where(level: 2): set text(fill: nblue, size: 12pt, weight: "regular")

  // Link styling
  show link: set text(fill: nred)

  // Raw/code styling
  show raw: set text(font: mono-fonts)
  show raw.where(block: true): it => {
    box(
      width: 100%,
      fill: black.lighten(97%),
      stroke: nblue,
      inset: 0.6em,
    )[
      #set text(size: 9pt)
      #it
    ]
  }

  // Table styling
  set table(
    stroke: none,
    inset: 0.5em,
  )

  show table: it => {
    set text(font: sans-fonts)
    it
  }

  body
}

// ============================================================================
// Convenience Exports
// ============================================================================

// Note: Polylux helpers can be imported directly by users if needed.
