# Makefile for NUMPEX presentation/poster templates
# Supports both LaTeX and Typst builds with separate output directories

# Directories
TEX_OUT = build/tex
TYPST_OUT = build/typst

# Source files
TEX_SOURCES = presentation.template.tex poster.template.tex
TYPST_SOURCES = presentation.template.typ poster.template.typ

# Output PDFs
TEX_PDFS = $(TEX_OUT)/presentation.template.pdf $(TEX_OUT)/poster.template.pdf
TYPST_PDFS = $(TYPST_OUT)/presentation.template.pdf $(TYPST_OUT)/poster.template.pdf

.PHONY: all tex typst clean clean-tex clean-typst dirs help

# Default: build both
all: tex typst

# Create output directories
dirs:
	@mkdir -p $(TEX_OUT) $(TYPST_OUT)

# Build all LaTeX documents
tex: dirs $(TEX_PDFS)

# Build all Typst documents
typst: dirs $(TYPST_PDFS)

# LaTeX build rules (uses latexmk with .latexmkrc config)
$(TEX_OUT)/%.pdf: %.tex
	latexmk -pdf $<

# Typst build rules (multiple font paths for Marianne and Roboto static fonts)
$(TYPST_OUT)/%.pdf: %.typ numpex.typ
	typst compile --root . --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static $< $@

# Convenience targets for individual documents
presentation-tex: dirs $(TEX_OUT)/presentation.template.pdf
presentation-typst: dirs $(TYPST_OUT)/presentation.template.pdf
poster-tex: dirs $(TEX_OUT)/poster.template.pdf
poster-typst: dirs $(TYPST_OUT)/poster.template.pdf

# Watch modes for live editing
watch-presentation-tex:
	latexmk -pvc -pdf presentation.template.tex

watch-presentation-typst:
	typst watch --root . --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static presentation.template.typ $(TYPST_OUT)/presentation.template.pdf

watch-poster-tex:
	latexmk -pvc -pdf poster.template.tex

watch-poster-typst:
	typst watch --root . --font-path fonts/Marianne/desktop --font-path fonts/Roboto/static poster.template.typ $(TYPST_OUT)/poster.template.pdf

# Clean targets
clean: clean-tex clean-typst

clean-tex:
	latexmk -C
	rm -rf $(TEX_OUT)

clean-typst:
	rm -rf $(TYPST_OUT)

# Help
help:
	@echo "NUMPEX Presentation/Poster Templates Build System"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Build targets:"
	@echo "  all                 Build both TeX and Typst (default)"
	@echo "  tex                 Build all LaTeX documents -> $(TEX_OUT)/"
	@echo "  typst               Build all Typst documents -> $(TYPST_OUT)/"
	@echo "  presentation-tex    Build presentation with LaTeX"
	@echo "  presentation-typst  Build presentation with Typst"
	@echo "  poster-tex          Build poster with LaTeX"
	@echo "  poster-typst        Build poster with Typst"
	@echo ""
	@echo "Watch modes (auto-rebuild on changes):"
	@echo "  watch-presentation-tex"
	@echo "  watch-presentation-typst"
	@echo "  watch-poster-tex"
	@echo "  watch-poster-typst"
	@echo ""
	@echo "Clean targets:"
	@echo "  clean               Clean all build artifacts"
	@echo "  clean-tex           Clean LaTeX artifacts only"
	@echo "  clean-typst         Clean Typst artifacts only"
