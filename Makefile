
DESTTREE ?= `kpsewhich -var-value TEXMFLOCAL`
SCRIPTVERSION = $(shell texlua ptex2pdf.lua --print-version)

README: README.md
	pandoc --from=markdown_github --to=plain --columns=80 README.md > README

README.md: ptex2pdf.lua
	texlua ptex2pdf.lua --readme > README.md

install: README.md
	mkdir -p $(DESTTREE)/scripts/ptex2pdf
	cp ptex2pdf.lua $(DESTTREE)/scripts/ptex2pdf
	mkdir -p $(DESTTREE)/doc/latex/ptex2pdf
	cp COPYING $(DESTTREE)/doc/latex/ptex2pdf/
	cp README.md $(DESTTREE)/doc/latex/ptex2pdf/README

release: README.md
	rm -rf ptex2pdf-$(SCRIPTVERSION)
	mkdir ptex2pdf-$(SCRIPTVERSION)
	cp ptex2pdf.lua COPYING ptex2pdf-$(SCRIPTVERSION)
	# only ship the mark down version of readme
	cp README.md ptex2pdf-$(SCRIPTVERSION)/README
	zip -r ptex2pdf-$(SCRIPTVERSION).zip ptex2pdf-$(SCRIPTVERSION)
	tar -cJf ptex2pdf-$(SCRIPTVERSION).tar.xz ptex2pdf-$(SCRIPTVERSION)
	rm -rf ptex2pdf-$(SCRIPTVERSION)

clean:
	-rm -f README

