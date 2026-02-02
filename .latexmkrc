# Latexmk configuration for NUMPEX presentation/poster templates
# Output all TeX artifacts to build/tex/ directory

$out_dir = 'build/tex';
$aux_dir = 'build/tex';

# Use lualatex for better font support (Marianne fonts)
$pdf_mode = 4;  # lualatex
$lualatex = 'lualatex -shell-escape -interaction=nonstopmode -file-line-error %O %S';

# Alternative: use pdflatex (uncomment if preferred)
# $pdf_mode = 1;
# $pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -file-line-error %O %S';

# Clean up extra files
$clean_ext = 'nav snm vrb';
