FILES = md/begin.md \
				md/gcc.md \
				md/stlink.md \

OUTPUT = stmenv.pdf

all:
	cat $(FILES) | pandoc -f markdown -o $(OUTPUT)
	pdfunite temp/title.pdf stmenv.pdf seminarski.pdf


