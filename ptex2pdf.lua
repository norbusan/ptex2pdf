#!/usr/bin/env texlua  

NAME = "ptex2pdf[.lua]"
VERSION = "0.4"
AUTHOR = "Norbert Preining <norbert@preining.info>"
SHORTDESC = NAME .. ": Convert Japanese TeX documents to pdf"
LONGDESC = [[
Main purpose of the script is easy support of Japanese typesetting
engines in TeXworks. As TeXworks typesetting setup does not allow
for multistep processing, this script runs one of the ptex based
programs (ptex, uptex, eptex, platex, uplatex) followed by dvipdfmx.
]]
USAGE = [[
Usage:  [texlua] ptex2pdf[.lua] { option | basename[.tex] } ... 
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
]]

LICENSECOPYRIGHT = [[
Originally based on musixtex.lua from Bob Tennent.

(c) Copyright 2012 Bob Tennent rdt@cs.queensu.ca
(c) Copyright 2013 Norbert Preining norbert@preining.info

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
  TLROOT/texmf-dist/scripts/ptex2pdf/
(where TLROOT is for example the root of your TeX Live installation)

Unix:
create a link in one of the bin dirs to the above file, in the
TeX Live case:
  TLROOT/bin/ARCH/ptex2pdf -> ../../texmf-dist/scripts/ptex2pdf/ptex2pdf.lua

Windows:
create a copy of runscript.exe as ptex2pdf.exe, in the TeX Live case:
  copy TLROOT/bin/win32/runscript.exe TLROOT/bin/win32/ptex2pdf.exe
]]
TEXWORKS = [[
Under Preferences > Typesetting add new entries, for example:

for ptex files:
  Name:         pTeX to pdf
  Program:      ptex2pdf
  Arguments:    -ot
                $synctexoption
                $fullname

for platex files:
  Name:         pLaTeX to pdf
  Program:      ptex2pdf
  Arguments:    -l
                -ot
                $synctexoption
                $fullname

for uptex files:
  Name:         upTeX to pdf
  Program:      ptex2pdf
  Arguments:    -u
                -ot
                $synctexoption
                $fullname

for uplatex files:
  Name:         upLaTeX to pdf
  Program:      ptex2pdf
  Arguments:    -l
                -u
                -ot
                $synctexoption
                $fullname

If you need special kanji encodings for one of these programs,
add the respective -kanji option after the $synctexoption. Example:

for platex files in SJIS encoding:
  Name:         pLaTeX/SJIS to pdf
  Program:      ptex2pdf
  Arguments:    -l
                -ot
                $synctexoption -kanji=sjis
                $fullname
]]
DEVELPLACE = "https://git.gitorious.org/tlptexlive/ptex2pdf.git"


CHANGELOG = [[
     version 0.1  2013-03-08 NP
       Initial release on blog
     version 0.2  2013-03-10 NP
       import into git repository
       support passing options on to tex and dvipdfm
       add README with TeXworks config options
     version 0.3  2013-05-01 NP
       include the readme in the lua code
       fix program name for -e -u
     version 0.4  2013-05-07 NP
       quote the filename with ", so that special chars do survive
       add an example for TeXworks for files with different kanji encoding
]]


function usage()
  print(USAGE)
end

function help()
  print(SHORTDESC)
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

if filename ~= "" and string.sub(filename, -4, -1) == ".tex" then
  filename = string.sub(filename, 1, -5)
end
if not io.open(filename .. ".tex", "r") then
  print("Non-existent file: ", filename .. ".tex")
  exit_code = 1
else
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
