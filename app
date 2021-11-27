#!/usr/bin/env fish
function checkdependence
  if test -e $argv
    echo -e "\033[32m[checkdependence]check passed - $argv exist\033[0m"
  else
    echo -e "\033[0;31m[checkdependence]check failed - plz install $argv\033[0m"
    exit
  end
end
function checknetwork
  if curl -s -L $argv[1] | grep -q $argv[2]
    echo -e "\033[32m[checknetwork]check passed - u`ve connected to $argv[1]\033[0m"
  else
    echo -e "\033[0;31m[checknetwork]check failed - check your network connection\033[0m"
  end
end
function dir_exist
  if test -d $argv[1]
    echo -e "\033[32m[checkdir]check passed - dir $argv[1] exist\033[0m"
  else
    echo -e "\033[0;31m[checkdir]check failed - dir $argv[1] doesn't exist,going to makr one\033[0m"
    mkdir $argv[1]
  end
end
function list_menu
ls $argv | sed '\~//~d'
end
function help_echo
  echo "==========Help Documentation=========="
  set_color green
  echo "(./)progynosh argv[1]"
  set_color normal
  echo " -argv[1]:the command to execute"
  echo "  -Available:
             install >>> install to /usr/bin
             uninstall >>> remove from /usr/bin

             init argv[2] >>> deploy the core files and structure for pynsh
              -argv[2] : the name of resource folder,default is the folder currently in

             build argv[2] argv[3] >>> Combine the progynosh script file to one fish shell script
              -argv[2] : the resource folder,default is the folder currently in
              -argv[3] : Set the name of output file,default is ./app

             get argv[2] >>> get libs from online repo
              -argv[2] : Name of the libs , view the list on github.com/happyeggchen/progynosh-script-source

             push argv[2] >>> do a auto git push
              -argv[2] : comments you want to commit,remember to use a \'\'

            transfer argv[2] argv[3] >>> rebase your project to a newer progynosh version
              -argv[2] : version you want to transfer
                -Available : (1) candlelight -> cloudgirl (just set the argv[2] as "1")               
              -argv[3] : the project folder you want to trans,default is the folder currently in

            version >>> show the version of progynosh"
  set_color yellow
  echo "Remember,do this in the project dir,otherwish your root dir will full of pynsh files"
  set_color normal
  echo "========================================"
end
set installname $argv[1]
function install
  set dir (realpath (dirname (status -f)))
  set filename (status --current-filename)
  chmod +x $dir/$filename
  sudo cp $dir/$filename /usr/bin/$installname
  set_color green
  echo "$prefix Installed"
  set_color normal
end
function uninstall
  sudo rm /usr/bin/$installname
  set_color green
  echo "$prefix Removed"
  set_color normal
end
function build
  set -g build_time (date +"%Y-%m-%d_%T" -u)
  set -g resource_dir $argv[1]
  set -g build_output $argv[2]
  if [ "$argv[1]" = "" ]
    set -g resource_dir .
  end
  if [ "$argv[2]" = "" ]
    set -g build_output app
  end
  if test -d $resource_dir
    echo "$prefix Building from $resource_dir/"
  else
    set_color red
      echo "$prefix No such resource folder found,process the argv as the output name,building from $resource_dir/"
      set -g build_output $resource_dir
      set -g resource_dir .
  end
  function app_fish_empty
    if test -e $build_output
      set_color red
        echo "$prefix A file this name existed,delete it anyway?[y/n]"
      set_color normal
      read -P "$prefix >>> " _delete_var_
      switch $_delete_var_
      case y
        rm $build_output
      case n '*'
        echo "$prefix Aborted"
	      exit
      end
    end
  end
  app_fish_empty
  for mod in (cat $resource_dir/configs/pynsh.mod)
    cat $resource_dir/libs/$mod >> $build_output
  end
  for dir_select in (ls $resource_dir/codes/)
    if test -d $resource_dir/codes/$dir_select
      set dir_select_empty (ls -A $resource_dir/codes/$dir_select)
      if test -z "$dir_select_empty"
      else
        cat $resource_dir/codes/$dir_select/** >> $build_output
      end
    else
      cat $resource_dir/codes/$dir_select >> $build_output
    end
  end
  echo "echo Build_Time_UTC=$build_time" >> $build_output
  cat $resource_dir/configs/main.fish >> $build_output
  chmod +x $build_output
  set -e build_output
  set -e resource_dir
  set_color green
  echo "$prefix Built"
  set_color normal
end
function init-files -d "write essential content to structure files"
set resource_dir $argv[1]
echo "header" > $resource_dir/configs/pynsh.mod
echo "#!/usr/bin/env fish" > $resource_dir/libs/header
echo "'MIT LICENSE
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'" > $resource_dir/docs/LICENSE
echo "A progynosh fish script doc
===========================
This is a script dev manager for fish script shell
>>>>> How To <<<<<
	1 >	write your script as functions in \$resource_dir/apps
	2 >	call them from \$resource_dir/main.fish
	3 >	use progynosh build to build a final fish script" > $resource_dir/docs/handbook.md
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
end" > $resource_dir/libs/base
touch $resource_dir/configs/main.fish
echo "cloudgirl" > $resource_dir/configs/version.lock
end
function init
  set -g resource_dir $argv[1]
  if [ "$argv[1]" = "" ]
    set resource_dir .
  end
    mkdir -p $resource_dir/codes
    mkdir -p $resource_dir/configs
    mkdir -p $resource_dir/docs
    mkdir -p $resource_dir/libs
    init-files $resource_dir
    echo "$prefix Deployed"
    set_color normal
  set -e resource_dir
end
function get -d "get libs from online repo"
  set -g modulename $argv[1]
  if [ "$argv[1]" = "" ]
    set_color red
    echo "$prefix Unexpect input"
    set_color normal
    exit
  end
  cd libs
  wget "https://github.com/happyeggchen/progynosh-script-source/raw/main/$modulename/$modulename"
  set_color cyan
  echo "$prefix Processed"
  set_color normal
end
function push -d "auto gitpush"
if [ "$argv[1]" = "" ]
  set commit_msg (date +"%Y-%m-%d_%T" -u)
else
  set commit_msg $argv[1]
end
git add .
git commit -m $commit_msg
git push
end
function candlelight2cloudgirl -d "update the folder structure"
  set resource_dir $argv[1]
  if [ "$argv[1]" = "" ]
    set resource_dir '.'
  end
  set_color yellow
  echo "$prefix Rebasing the folder structure"
  set_color normal
    dir_exist $resource_dir/configs
    dir_exist $resource_dir/docs
    if test -d $resource_dir/fish_libs
      if test -d $resource_dir/fish_libs/apps
        echo "$prefix Found old codes folder,moving to new one"
        mv $resource_dir/fish_libs/apps $resource_dir/codes
      end
      if test -d $resource_dir/fish_libs/libs
        echo "$prefix Found old libraries folder,moving to new one"
        mv $resource_dir/fish_libs/libs $resource_dir/libs
      end
      if test -e $resource_dir/fish_libs/main.fish
        echo "$prefix Found old main.fish caller,moving to new one"
        mv $resource_dir/fish_libs/main.fish $resource_dir/configs/main.fish
      end
      mv $resource_dir/fish_libs $resource_dir/rebased-trash-bin
    end
    if test -e $resource_dir/pynsh.mod
      echo "$prefix Found old libraries declear files,moving to new one"
      mv $resource_dir/pynsh.mod $resource_dir/configs/pynsh.mod
    end
    dir_exist $resource_dir/codes
    dir_exist $resource_dir/libs
    set_color green
    echo "$prefix Done,your project had been rebased"
    set_color normal
end
echo Build_Time_UTC=2021-11-27_03:58:32
set prefix "[Progynosh]"
set_color cyan
echo "$prefix progynosh fish shell script dev manager | by tsingkwai@protonmail.com (tsingkwai.ruzhtw.top)"
set_color normal
switch $argv[1]
case install
  install progynosh
case uninstall
  uninstall progynosh
case init
  init $argv[2]
case build
  build $argv[2] $argv[3]
case get
  get $argv[2]
case push
  push $argv[2]
case transfer
  switch $argv[2]
  case 1
    candlelight2cloudgirl $argv[3]
  case h help '*'
    set_color red
    echo "$prefix Unexpected input"
    set_color normal
  end
case v version
  set_color yellow
  echo "CloudGirl v1.1"
case h help '*'
  help_echo
end
