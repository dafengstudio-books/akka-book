# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = python -msphinx
SPHINXPROJ    = akka-book
SOURCEDIR     = .
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

open-html:
	open _build/html/index.html


push:
	git add .
	git commit -a -m 'auto commit'
	git push origin master

build-html: html
	cp -vrf _build/html/* ./docs/
	git add docs/*
	git commit -a -m 'auto publish'
	cd docs;make html

publish:
	rm -vrf dafengstudio-books.akka-book|true
	mkdir -p dafengstudio-books.akka-book
	git clone https://yishenggudou:78a8f13f5d9d28bc5af48a8b33b77be4ee76a9a7@github.com/dafengstudio-books/akka-book.git dafengstudio-books.akka-book
	cp -vrf docs/* dafengstudio-books.akka-book/docs/
	cd dafengstudio-books.akka-book;git config user.name yishenggudou;git config user.email yishenggudou@gmail.com
	cd dafengstudio-books.akka-book;git add docs/* -f ;git commit -a -m 'auto build by github action'; git push origin