WORKDIR = .

.PHONY: all

all: ha_03_Felix_09.pdf

# Test LaTeX build

ha_03_Felix_09.pdf: ha_03_Felix_09.tex
	latexmk -pdf -pdflatex="lualatex -interaction=nonstopmode -synctex=1 %O %S" $(WORKDIR)/ha_03_Felix_09.tex
