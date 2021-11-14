$pdf_mode = 1;
my @clean_ext = qw(
  %R-blx.bib
  run.xml
  bbl
  synctex.gz
);
$clean_ext = join ' ', @clean_ext;
