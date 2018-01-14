# cu-LO
Church Slavonic extensions for LibreOffice

Includes Church Slavic (Church Slavonic) hyphenation and spelling dictionaries for LibreOffice.

## Requirements

- LibreOffice 5.0 or greater (while the dictionary will install in earlier versions,
  you will not be able to use it since the earlier versions do not have
  Church Slavic as an available locale)

## Installation

You can get the extension from the
[Extensions website](https://extensions.libreoffice.org/extensions/church-slavonic-dictionary).
Use this repository only if you want to change something
and rebuild from source.

## Compilation Requirements

To build from source, you will need
- An Internet connection
- Perl 5 installed 

## Quick Start

To build LibreOffice extension, just do this:
```
make
```
Result should be a file `cu-LO.oxt` which you can then install into LibreOffice

## Documentation

The hyphenation dictionary is based on the TeX hyphenation patterns for Church Slavonic.
See [cu-tex package hyphenation README](https://github.com/slavonic/cu-tex/tree/master/hyphenation) for more information.

The spelling dictionary is based on the Hunspell spelling dictionary for Church Slavonic.
Morphological analysis is not (yet) supported. See
See [hunspell-cu package README](https://github.com/slavonic/hunspell-cu)
for more information.

## Bugs

Report in issue tracker. Be sure to specify version of LO and platform.
There are bugs with case folding and word boundary recognition for Cyrillic 
in LibreOffice. It is hoped that these will be fixed in version 6.0.
See the [issue tracker for LO](https://bugs.documentfoundation.org/show_bug.cgi?id=96343).

