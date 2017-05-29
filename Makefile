FILES = md/title.md \
				md/begin.md \
				sh/arm_setup.sh \
				md/stlink.md \
				sh/st-link-install.sh \

OUTPUT = stmenv.pdf

all:
	cat $(FILES) | pandoc -f markdown -o $(OUTPUT)

