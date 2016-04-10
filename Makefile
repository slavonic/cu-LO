all: cu-LO.oxt

clean:
	rm -f cu-LO.oxt
	rm -f hyph_cu_RU/hyph_cu_RU.dic

cu-LO.oxt:
	rm -f substrings.pl
	rm -f hyph_cu_RU/1.tmp
	rm -f hyph_cu_RU/2.tmp
	# fetching substrings script
	wget https://raw.githubusercontent.com/hunspell/hyphen/master/substrings.pl
	# creating patterns file
	awk '/\\patterns/{flag=1;next}/}/{flag=0}flag' cu-tex/hyphenation/hyph-cu.tex > hyph_cu_RU/1.tmp
	cat cu-tex/hyphenation/hyph-cu.err >> hyph_cu_RU/1.tmp
	# converting TeX patterns to LO format
	perl substrings.pl hyph_cu_RU/1.tmp hyph_cu_RU/2.tmp UTF-8 1 2
	# adding rules for compound words
	sed -n -e '1,/RIGHTHYPHENMIN/p' hyph_cu_RU/2.tmp > hyph_cu_RU/hyph_cu_RU.dic
	echo 'COMPOUNDLEFTHYPHENMIN 1\nCOMPOUNDRIGHTHYPHENMIN 2\nNOHYPHEN -,_\n1-1\n1_1\nNEXTLEVEL' >> hyph_cu_RU/hyph_cu_RU.dic
	sed '1,/RIGHTHYPHENMIN/d' hyph_cu_RU/2.tmp >> hyph_cu_RU/hyph_cu_RU.dic
	# bundling the LO extension
	rm -f hyph_cu_RU/2.tmp
	rm -f hyph_cu_RU/1.tmp
	rm -f substrings.pl
	zip -rv cu-LO.oxt hyph_cu_RU META-INF description.xml dictionaries.xcu LICENSE README.md

