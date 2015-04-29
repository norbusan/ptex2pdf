#!/usr/bin/env texlua

NAME = "ptex2pdf[.lua]"
VERSION = "0.7"
AUTHOR = "Norbert Preining"
AUTHOREMAIL = "norbert@preining.info"
SHORTDESC = "Convert Japanese TeX documents to pdf"
LONGDESC = [[
Main purpose of the script is easy support of Japanese typesetting
engines in TeXworks. As TeXworks typesetting setup does not allow
for multistep processing, this script runs one of the ptex based
programs (ptex, uptex, eptex, platex, uplatex) followed by dvipdfmx.
]]
USAGE = [[
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
         -od '<opts>' extra options for dvipdfmx]]

LICENSECOPYRIGHT = [[
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
]]

INSTALLATION = [[
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
]]

TEXWORKS = [[
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
]]

DEVELPLACE = "http://github.com/norbusan/ptex2pdf"


CHANGELOG = [[
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
]]


function usage()
  print(USAGE)
end

function makereadme()
  print("# " .. NAME .. " #")
  print()
  print("**Author:** " .. AUTHOR .. "  ")
  print("**Website:** http://www.preining.info/blog/software-projects/ptex2pdf/ (in Japanese)  ")
  print("**License:** GPLv2")
  print()
  print(SHORTDESC)
  print()
  print("## Description ##")
  print()
  print(LONGDESC)
  print("## Usage ##")
  print()
  print("`````")
  print(USAGE)
  print("`````")
  print()
  print("## Installation ##")
  print()
  print(INSTALLATION)
  print("## TeXworks setup ##")
  print()
  print(TEXWORKS)
  print()
  print("## Development place ##")
  print()
  print(DEVELPLACE)
  print()
  print("## Changelog ##")
  print()
  print(CHANGELOG)
  print("## Copyright and License ##")
  print()
  print(LICENSECOPYRIGHT)
end

function help()
  print(NAME .. ": " .. SHORTDESC)
  print()
  print("Author: " .. AUTHOR)
  print()
  print(LONGDESC)
  print(USAGE)
end

function fullhelp()
  help()
  print("Installation")
  print("------------")
  print(INSTALLATION)
  print("TeXworks setup")
  print("--------------")
  print(TEXWORKS)
  print("Development place")
  print("-----------------")
  print(DEVELPLACE)
  print()
  print("Copyright and License")
  print("---------------------")
  print(LICENSECOPYRIGHT)
end

function whoami ()
  print("This is " .. NAME .. " version ".. VERSION .. ".")
end

if #arg == 0 then
  usage()
  os.exit(0)
end

-- defaults:
tex = "ptex"
texopts = ""
dvipdf = "dvipdfmx"
dvipdfopts = ""
intermediate = 1

use_eptex = 0
use_uptex = 0
use_latex = 0
filename = ""
exit_code = 0
narg = 1
repeat
  this_arg = arg[narg]
  if this_arg == "-v" then
    whoami()
    os.exit(0)
  elseif this_arg == "--readme" then
    makereadme()
    os.exit(0)
  elseif this_arg == "--print-version" then
    print(VERSION)
    os.exit(0)
  elseif this_arg == "-h" then
    help()
    os.exit(0)
  elseif this_arg == "--help" then
    fullhelp()
    os.exit(0)
  elseif this_arg == "-e" then
    use_eptex = 1
  elseif this_arg == "-u" then
    use_uptex = 1
  elseif this_arg == "-l" then
    use_latex = 1
  elseif this_arg == "-s" then
    dvipdf = ""
  elseif this_arg == "-i" then
    intermediate = 0
  elseif this_arg == "-ot" then
    narg = narg+1
    texopts = arg[narg]
  elseif this_arg == "-od" then
    narg = narg+1
    dvipdfopts = arg[narg]
  else
    filename = this_arg 
  end --if this_arg == ...
  narg = narg+1
until narg > #arg 

whoami()

if use_eptex == 1 then
  if use_uptex == 1 then
    if use_latex == 1 then
      tex = "uplatex"	-- uplatex already as etex extension
    else
      tex = "euptex"
    end
  else
    if use_latex == 1 then
      tex = "platex"    -- latex needs etex anyway
    else
      tex = "eptex"
    end
  end
else
  if use_uptex == 1 then
    if use_latex == 1 then
      tex = "uplatex"
    else
      tex = "uptex"
    end
  else
    if use_latex == 1 then
      tex = "platex"
    else
      tex = "ptex"
    end
  end
end

-- initialize kpse
kpse.set_program_name(tex)

if filename ~= "" and string.sub(filename, -4, -1) == ".tex" then
  filename = string.sub(filename, 1, -5)
end

-- if not io.open(filename .. ".tex", "r") then
--   print("Non-existent file: ", filename .. ".tex")
--   exit_code = 1
if ( kpse.find_file(filename .. ".tex") == nil ) then
   print("File cannot be found with kpathsea: ", filename .. ".tex")
   exit_code = 1
else
  -- make sure that on Windows/uptex we are using utf8 as command line encoding
  if use_uptex == 1 then
    if os.type == 'windows' then
      os.setenv('command_line_encoding', 'utf8')
    end
  end
  print("Processing ".. filename .. ".tex.")
  if (os.execute(tex .. " " .. texopts .. " \"" .. filename .. "\"") == 0) and
     (dvipdf == "" or  (os.execute(dvipdf .. " " .. dvipdfopts .. " \"" .. filename .. "\"") == 0))
    then 
      if dvipdf ~= "" then 
        print(filename .. ".pdf generated by " .. dvipdf .. ".")
      end
      if intermediate == 1 then -- clean-up:
        if dvipdf ~= "" then
          os.remove( filename .. ".dvi" )
        end
      end
    else
      print("ptex2pdf processing of " .. filename .. ".tex fails.\n")
      exit_code = 2
      --[[ uncomment for debugging
      print("tex = ", tex)
      print("dvipdf = ", dvipdf)
      --]]
    end
end --if not io.open ...

os.exit( exit_code )



-- Local Variables:
-- lua-indent-level: 2
-- tab-width: 2
-- indent-tabs-mode: nil
-- End:
-- vim:set tabstop=2 expandtab: #
