SHELL = /usr/bin/env bash
BOOK=tlabook-doc

.PHONY: all
all: $(BOOK).pdf


$(BOOK).pdf: $(BOOK).tex *.sty
	latexmk

clean:
	rm -f $(BOOK).idx $(BOOK).fdb* $(BOOK).log $(BOOK).lof \
	      $(BOOK).lol $(BOOK).lot $(BOOK).toc $(BOOK).ilg \
	      $(BOOK).ing $(BOOK).ptc $(BOOK).fls $(BOOK).ind \
	      $(BOOK).aux $(BOOK).bbl

remove:
	rm -f $(BOOK).pdf

.PHONY: view
view: $(BOOK).pdf
	open $(BOOK).pdf

-include Makefile.local.mk
