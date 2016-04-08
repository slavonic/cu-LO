#!/usr/bin/perl

use warnings;
use strict;
use utf8;

## this script reads the TeX hyphenation patterns and creates a LO 
## hyphenation dictionary
my $input_file = "cu-tex/hyphenation/hyph-cu.tex";
my $output_path = "hyph_cu_RU";
my $path_to_substrings = "https://raw.githubusercontent.com/hunspell/hyphen/master/substrings.pl";

# step 0: fetch the substrings script from the Hyphen repository
system ("wget $path_to_substrings");

unless (-e "substrings.pl") {
	print "Fatal error: unable to find substrings.pl\n";
	print "Please check if you have an Internet connection\n";
	exit 1;
}

# step 1: read in the TeX hyphenation pattern data
# remove all TeX stuff, keeping only patterns
# convert word list to more patterns
# write to temporary file 1.tmp
open (INPUT, "<:encoding(UTF-8)", $input_file) || die "Cannot read from input file: $!";
open (TMP1, ">:encoding(UTF-8)", "$output_path/1.tmp") || die "Cannot write to temporary file: $!";
my $write = 0;
my $process = 0;

while (<INPUT>) {
	s/\r?\n//g;
	if (index($_, "patterns{") != -1) {
		$write++;
		next;
	}
	if (index($_, "}") != -1 && $write) {
		$write--;
		next;
	}
	if (index($_, "hyphenation{") != -1) {
		$process++;
		next;
	}
	if (index($_, "}") != -1 && $process) {
		$process--;
		next;
	}

	if ($write) {
		print TMP1 $_ , "\n";
	} elsif ($process) {
		s/\-/1/g;
		print TMP1 "." . $_ . ".", "\n";
	}
}

close (TMP1);
close (INPUT);

# step 2: run the substrings script that comes with the HYPHEN package
# print the results to a second temporary file, 2.tmp
system ("perl substrings.pl $output_path/1.tmp $output_path/2.tmp UTF-8 1 2");

# step 3: edit 2.tmp, adding additional information for compound words
# print the results to hyph_cu_RU.dic (this is the final dictionary file)
open (TMP2, "<:encoding(UTF-8)", "$output_path/2.tmp") || die "Cannot read from temporary file: $!";
open (OUTPUT, ">:encoding(UTF-8)", "$output_path/hyph_cu_RU.dic") || die "Cannot write to file: $!";
while (<TMP2>) {
	s/\r?\n//g;
	if (index($_, "RIGHTHYPHENMIN") != -1) {
		print OUTPUT $_, "\n";
		print OUTPUT qq(COMPOUNDLEFTHYPHENMIN 1
COMPOUNDRIGHTHYPHENMIN 2
NOHYPHEN -,_
1-1
1_1
NEXTLEVEL);
		print OUTPUT "\n";
	} else {
		print OUTPUT $_, "\n";
	}
}
close (OUTPUT);
close (TMP2);

# cleanup, deleting temporary files
unlink "$output_path/1.tmp";
unlink "$output_path/2.tmp";
unlink "substrings.pl";

exit 0;
