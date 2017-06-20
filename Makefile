FILES = md/begin.md \
				md/gcc.md \
				md/stlink.md \
				md/debug.md \

OUTPUT = stmenv.pdf

all:
	cat $(FILES) | pandoc -V geometry:margin=1in -f markdown -o temp.pdf 
	pdfunite temp/title.pdf temp.pdf $(OUTPUT)
	rm -rf temp.pdf 

docs:
	cat $(FILES) > index.md
	mv index.md ./docs/

