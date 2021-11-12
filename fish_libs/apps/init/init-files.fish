function init-files -d "write essential content to structure files"
echo "header" > pynsh.mod
echo "#!/usr/bin/env fish" > fish_libs/libs/header
echo "'Copyright <YEAR> <COPYRIGHT HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'" > LICENSE
echo "A progynosh fish script doc
===========================
This is a script dev manager for fish script shell
>>>>> How To <<<<<
	1 >	write your script as functions in fish_libs/apps
	2 >	call them from fish_libs/main.fish
	3 >	use progynosh build to build a final fish script" > handbook.md
echo "function checkdependence
  if test -e \$argv
    echo -e \"\033[32m[checkdependence]check passed - \$argv exist\033[0m\"
  else
    echo -e \"\033[0;31m[checkdependence]check failed - plz install \$argv\033[0m\"
    exit
  end
end
function checknetwork
  if curl -s -L \$argv[1] | grep -q \$argv[2]
    echo -e \"\033[32m[checknetwork]check passed - u`ve connected to \$argv[1]\033[0m\"
  else
    echo -e \"\033[0;31m[checknetwork]check failed - check your network connection\033[0m\"
  end
end
function dir_exist
  if test -d \$argv[1]
    echo -e \"\033[32m[checkdir]check passed - dir \$argv[1] exist\033[0m\"
  else
    echo -e \"\033[0;31m[checkdir]check failed - dir \$argv[1] doesn't exist,going to makr one\033[0m\"
    mkdir \$argv[1]
  end
end
function list_menu
ls \$argv | sed '\~//~d'
end" > fish_libs/libs/base
end
