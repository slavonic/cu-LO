all: cu-LO.oxt

clean:
	rm -f cu-LO.oxt
	rm -f hyph_cu_RU/hyph_cu_RU.dic

cu-LO.oxt:
	# building the LO patterns from the TeX patterns
	perl build.pl
	# bundling the LO extension
	zip -rv cu-LO.oxt hyph_cu_RU META-INF description.xml dictionaries.xcu LICENSE README.md
