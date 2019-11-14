SLIDES_PDF := $(patsubst %.md,%.pdf,$(wildcard *.slides.md))

all: $(SLIDES_PDF)

%.slides.pdf: %.slides.md
	pandoc $^ -t beamer -o $@ --slide-level 1 --template vzg-slides.tex \
		--pdf-engine=xelatex --

clean:
	rm -rf $(SLIDES_PDF)
