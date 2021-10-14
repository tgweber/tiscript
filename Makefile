SHELL=/bin/bash
LATEX=pdflatex
LATEXOPT=--shell-escape

LATEXMK=latexmk
LATEXMKOPT=-pdf

BIBER=biber
GLOS=makeglossaries

MAIN=script

SOURCES=$(MAIN).tex Makefile $(find content/*)

all:	$(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES)
		$(LATEXMK) $(LATEXMKOPT) \
			-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)
		$(BIBER) $(MAIN)
		$(GLOS) $(MAIN)
		$(LATEXMK) $(LATEXMKOPT) \
			-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)
		# scp $(MAIN).pdf melchior@kushida.uberspace.de:html/$(MAIN)_bkp.pdf 

force:
		touch .refresh
		rm $(MAIN).pdf
		$(LATEXMK) $(LATEXMKOPT) \
			-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)
		# scp $(MAIN).pdf melchior@kushida.uberspace.de:html/diss_bkp.pdf

clean:
		$(LATEXMK) -C $(MAIN)
		rm -f $(MAIN).pdfsync
		rm -rf *~ *.tmp
		rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk *.tdo $(MAIN).mtc*

publish:
		scp $(MAIN).pdf melchior@kushida.uberspace.de:html/$(MAIN)_bkp.pdf 
		git push origin master

once:
		$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

.PHONY: clean force once all

