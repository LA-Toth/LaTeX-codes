SHELL = /usr/bin/env bash
.PHONY: all
all: tlabook-sample.pdf

tlabook-sample.pdf: tlabook-sample.tex *.sty
	latexmk

clean:
	rm -f tlabook-sample.idx tlabook-sample.fdb* tlabook-sample.log tlabook-sample.lof \
	      tlabook-sample.lol tlabook-sample.lot tlabook-sample.toc tlabook-sample.ilg \
	      tlabook-sample.ing tlabook-sample.ptc tlabook-sample.fls tlabook-sample.ind \
	      tlabook-sample.aux tlabook-sample.bbl

remove:
	rm tlabook-sample.pdf

.PHONY: view
view: tlabook-sample.pdf
	open tlabook-sample.pdf

-include Makefile.local.mk
