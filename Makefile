# Copyright (c) 2022 Changkun Ou. All rights reserved.

MAJOR_NAME=paper

all: draft

draft:
	echo '\documentclass[manuscript,authordraft,screen]{acmart}' > style/mode.tex
	make major
	make suppl
	make clean

submit:
	echo '\documentclass[manuscript,review,anonymous]{acmart}' > style/mode.tex
	make major
	make suppl
	make clean

release:
	echo '\documentclass[sigconf]{acmart}' > style/mode.tex
	make major
	make suppl
	make clean

major:
	echo '\setboolean{major}{true}'   > style/compile.tex
	echo '\setboolean{suppl}{false}' >> style/compile.tex
	latexmk -pdf main.tex -jobname=$(MAJOR_NAME)
suppl:
	echo '\setboolean{major}{false}'    > style/compile.tex
	echo '\setboolean{suppl}{true}'    >> style/compile.tex
	echo '\\externaldocument{$(MAJOR_NAME)}' >> style/compile.tex
	latexmk -pdf main.tex -jobname=$(MAJOR_NAME)-suppl
	make clean

clean:
	rm -rf *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out *.cut *.dvi *.xcp