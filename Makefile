FILES = md/begin.md \
				help/bash_begin.md \
				sh/arm_setup.sh \
				help/bash_end.md \
				md/stlink.md \
				help/bash_begin.md \
				sh/st-link-install.sh \
				help/bash_end.md

OUTPUT = stmenv.pdf

all:
	cat $(FILES) | pandoc -f markdown -o $(OUTPUT)

