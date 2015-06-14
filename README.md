# ptex2pdf[.lua] #

**Author:** Norbert Preining  
**Website:** http://www.preining.info/blog/software-projects/ptex2pdf/ (in Japanese)  
**License:** GPLv2

Convert Japanese TeX documents to pdf

## Description ##

Main purpose of the script is easy support of Japanese typesetting
engines in TeXworks. As TeXworks typesetting setup does not allow
for multistep processing, this script runs one of the ptex based
programs (ptex, uptex, eptex, platex, uplatex) followed by dvipdfmx.

## Usage ##

`````
[texlua] ptex2pdf[.lua] { option | basename[.tex] } ... 
options: -v  version
         -h  help
         --help print full help (installation, TeXworks setup)
         -e  use eptex class of programs
         -u  use uptex class of programs
         -l  use latex based formats
         -s  stop at dvi
         -i  retain intermediate files
         -ot '<opts>' extra options for TeX
         -od '<opts>' extra options for dvipdfmx
`````

## Installation ##

Copy the file ptex2pdf.lua into a directory where scripts are found,
that is for example

  `TLROOT/texmf-dist/scripts/ptex2pdf/`

(where `TLROOT` is for example the root of your TeX Live installation)

### Unix ###

create a link in one of the bin dirs to the above file, in the
TeX Live case:

  `TLROOT/bin/ARCH/ptex2pdf -> ../../texmf-dist/scripts/ptex2pdf/ptex2pdf.lua`

### Windows ###
create a copy of runscript.exe as ptex2pdf.exe, in the TeX Live case:

  `copy TLROOT/bin/win32/runscript.exe TLROOT/bin/win32/ptex2pdf.exe`

## TeXworks setup ##

Under Preferences > Typesetting add new entries, for example:

for ptex files:

| Setting     |  Value           |
|-------------|------------------|
| Name:       |  pTeX to pdf     |
| Program:    |  ptex2pdf        |
| Arguments:  |  -ot             |
|             |  $synctexoption  |
|             |  $fullname       |


for platex files:

| Setting     | Value          |
|-------------|----------------|
| Name:       | pLaTeX to pdf  |
| Program:    | ptex2pdf       |
| Arguments:  | -l             |
|             | -ot            |
|             | $synctexoption |
|             | $fullname      |

for uptex files:

| Setting     | Value          |
|-------------|----------------|
| Name:       | upTeX to pdf   |
| Program:    | ptex2pdf       |
| Arguments:  | -u             |
|             | -ot            |
|             | $synctexoption |
|             | $fullname      |

for uplatex files:

| Setting     | Value          |
|-------------|----------------|
| Name:       | upLaTeX to pdf |
| Program:    | ptex2pdf       |
| Arguments:  | -l             |
|             | -u             |
|             | -ot            |
|             | $synctexoption |
|             | $fullname      |

If you need special kanji encodings for one of these programs,
add the respective `-kanji` option after the `$synctexoption`. Example:

for platex files in SJIS encoding:

| Setting     | Value                       |
|-------------|-----------------------------|
| Name:       | pLaTeX/SJIS to pdf          |
| Program:    | ptex2pdf                    |
| Arguments:  | -l                          |
|             | -ot                         |
|             | $synctexoption -kanji=sjis  |
|             | $fullname                   |


## Development place ##

http://github.com/norbusan/ptex2pdf

## Changelog ##

- version 0.1  2013-03-08 NP
  Initial release on blog
- version 0.2  2013-03-10 NP
  import into git repository
  support passing options on to tex and dvipdfm
  add README with TeXworks config options
- version 0.3  2013-05-01 NP
  include the readme in the lua code
  fix program name for -e -u
- version 0.4  2013-05-07 NP
  quote the filename with ", so that special chars do survive
  add an example for TeXworks for files with different kanji encoding
- version 0.5  2014-11-05 NP
  on Windows: set command_line_encoding to utf8 when running uptex
  (patch by Akira Kakuto)
- version 0.6  2015-03-08 NP
  cygwin didn't like the (accidentally inserted) spaces after the
  texlua in the shebang line, and stopped working with
    "no such program: "texlua  " ..."
- version 0.7dev 2015-XX-XX
  move to github as gitorious will be closed, adapt help output
  to generate github flavored markdown
  check for files using kpathsea instead of opening directly, to allow
  for input of files found by kpathsea (closes github issue 1)
  file name checks: first search for arg as is, then try .tex and .ltx
  (closes github issue: 3)

## Copyright and License ##

Originally based on musixtex.lua from Bob Tennent.

(c) Copyright 2012 Bob Tennent rdt@cs.queensu.ca  
(c) Copyright 2013-2015 Norbert Preining norbert@preining.info  

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

