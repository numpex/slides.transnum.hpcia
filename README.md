# NumPEx Presentation & Poster Templates (LaTeX + Typst)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15113190.svg)](https://doi.org/10.5281/zenodo.15113190)
[![GitHub Release](https://img.shields.io/github/v/release/numpex/presentation.template)](https://github.com/numpex/presentation.template/releases/latest)
[![PyPI - article-cli](https://img.shields.io/pypi/v/article-cli?label=article-cli)](https://pypi.org/project/article-cli/)
[![Slack](https://img.shields.io/badge/slack-presentation-brightgreen.svg?logo=slack)](https://numpex.slack.com/archives/C08L4KHUTFX)
[![Slack](https://img.shields.io/badge/slack-notifications-blue.svg?logo=slack)](https://numpex.slack.com/archives/C08KRJF3B55)


## Getting Started

This template uses [article-cli](https://pypi.org/project/article-cli/) for project management.

### Installation

```bash
pip install article-cli
```

### Quick Start

Clone the repository and add the path to your `TEXINPUTS` environment variable, then use the theme in your presentation:

```latex
\usetheme{numpex}
```

### Slides Template

Compile `presentation.template.tex`:

```bash
article-cli compile --engine xelatex presentation.template.tex
```

### Poster Template

Compile `poster.template.tex`:

```bash
article-cli compile --engine xelatex poster.template.tex
```

## Typst (VS Code)

This repository also includes Typst equivalents:

- Presentation: `presentation.template.typ`
- Poster: `poster.template.typ`

### Recommended VS Code extension

Install **Tinymist Typst** (`myriad-dreamin.tinymist`). It provides syntax highlighting, diagnostics, formatting, and the preview.

This repo already ships a minimal formatter setup in `.vscode/settings.json`.

### Install Typst (macOS)

The most reliable setup is to install the Typst compiler via Homebrew:

```bash
brew install typst
```

Optional:

```bash
brew install typstfmt
```

### Does it compile automatically?

- When the **Preview** is open, Tinymist typically re-compiles on edits/saves.
- If the preview is blank, it usually means there is a compilation error.

### Preview and build from the CLI

From the repository root:

```bash
# Using article-cli (recommended)
article-cli compile presentation.template.typ
article-cli compile poster.template.typ

# Or using typst directly
typst compile presentation.template.typ --root .
typst compile poster.template.typ --root .
```

### Blank preview troubleshooting

- Open the **Problems** panel (compilation errors show up there).
- Open the **Output** panel and select **Tinymist** to see the compiler logs.
- Make sure you preview the entrypoint (`presentation.template.typ` or `poster.template.typ`), not the theme/library file.

## Fonts

For the best result, you should install the [Marianne font](https://www.systeme-de-design.gouv.fr/elements-d-interface/fondamentaux-de-l-identite-de-l-etat/typographie/) and compile with XeLaTeX.

### Installing Fonts

Install the required fonts (Marianne and Roboto) using article-cli:

```bash
article-cli install-fonts
```

This downloads and extracts the fonts into the `fonts/` directory within your project. The `beamerfontthemenumpex` package is already configured to use fonts from this relative path.

### Typst fonts

Typst uses the fonts installed on your system. For best results, install **Marianne** (and a mono font like **Roboto Mono**) system-wide.

### Typst fonts (repo-local, no system install)

If you want a fully local setup (use the committed fonts in `fonts/` without installing anything into macOS Font Book), use Typst with explicit font paths via article-cli:

```bash
# Compile with local fonts
article-cli compile presentation.template.typ --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static

# Watch mode with local fonts
article-cli compile presentation.template.typ --watch --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static

# Compile poster
article-cli compile poster.template.typ --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static
```

This gives you automatic rebuilds and correct fonts without system installation.

### Manual Font Configuration

If you prefer manual installation, ensure your LaTeX configuration points to the `fonts/` directory.

## Using This Theme in Other Projects

You can install this theme in any LaTeX project using article-cli:

```bash
# Install the numpex theme (default)
article-cli install-theme numpex

# Or install from a custom URL
article-cli install-theme --url https://github.com/numpex/presentation.template.d/archive/refs/heads/main.zip

# List available themes
article-cli install-theme --list
```

## CI/CD Pipeline

This repository includes a GitHub Actions workflow that uses article-cli to compile both LaTeX and Typst documents in parallel and create releases. The workflow is triggered on pushes to branches and tags.

### Workflow Steps

1. **Setup:** Installs Python and article-cli
2. **Install Fonts:** Downloads required fonts using `article-cli install-fonts`
3. **Build LaTeX:** Compiles LaTeX documents using XeLaTeX via `article-cli compile`
4. **Build Typst:** Compiles Typst documents via `article-cli compile` (runs in parallel with LaTeX)
5. **Check Artifacts:** Verifies that generated artifacts can be recompiled
6. **Release:** Creates GitHub releases for tagged commits (e.g., `v1.0.0`)

### Controlling Build Engines

You can skip LaTeX or Typst builds using three methods (in order of precedence):

#### 1. Workflow Dispatch (Manual Runs)

When triggering the workflow manually, you can check the "Skip LaTeX build" or "Skip Typst build" options.

#### 2. Commit Message Flags

Add flags to your commit message to skip specific builds:

```bash
# Skip LaTeX build
git commit -m "Update styles [skip latex]"
git commit -m "Fix typo [skip tex]"

# Skip Typst build
git commit -m "Update LaTeX only [skip typst]"
git commit -m "Fix beamer issue [skip typ]"

# Skip both (only runs setup)
git commit -m "Update README [skip tex] [skip typ]"
```

#### 3. Project Configuration

Configure which engines are enabled in `pyproject.toml`:

```toml
[tool.article-cli.project]
type = "presentation"
engines = ["latex", "typst"]  # Remove an engine to disable it
```

If an engine is not listed in the `engines` array, its build will be skipped in CI.

## Usage

### Setup Project

```bash
article-cli setup
```

### Compile Documents

```bash
# Compile with XeLaTeX (required for custom fonts)
article-cli compile --engine xelatex presentation.template.tex

# Compile all .tex files in the project
article-cli compile --engine xelatex
```

### Create a Release

```bash
article-cli create v1.0.0
```

### List Releases

```bash
article-cli list
```

### Clean Build Artifacts

```bash
article-cli clean
```

## Configuration

Project settings are managed in `pyproject.toml`:

```toml
[tool.article-cli.project]
type = "presentation"
engines = ["latex", "typst"]  # Controls which builds run in CI

[tool.article-cli.latex]
engine = "xelatex"
shell_escape = true
build_dir = "build/tex"

[tool.article-cli.typst]
font_paths = ["fonts/Marianne/desktop", "fonts/Roboto/static"]
build_dir = "build/typst"

[tool.article-cli.workflow]
output_dir = "build"
fonts_dir = "fonts"
install_fonts = true
```

## Contributing

Feel free to open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
