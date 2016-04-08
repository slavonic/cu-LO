# cu-LO
Church Slavonic extensions for LibreOffice

Includes Church Slavic (Church Slavonic) hyphenation dictionary for LibreOffice

## Requirements

- LibreOffice 5.0 or greater (while the dictionary will install in earlier versions,
  you will not be able to use it since the earlier versions do not have
  Church Slavic as an available locale)

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

This dictionary is based on the TeX hyphenation patterns for Church Slavonic.
See [cu-tex package hyphenation README](https://github.com/slavonic/cu-tex/tree/master/hyphenation) for more information.

## Bugs

Report in issue tracker. Be sure to specify version of LO and platform.

