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

             new argv[2] argv[3..-1] >>> create a new fish shell script in codes
              -argv[2] : the name of resource folder,default is the folder currently in
              -argv[3..-1] : The new script name
              Example : (./)progynosh new . 'activity/test/hi'

             init argv[2] >>> deploy the core files and structure for pynsh
              -argv[2] : the name of resource folder,default is the folder currently in

             bundle argv[2] >>> merge the script with a binary file
              -argv[2] : guider
                -Available :tui,cui

             build argv[2] argv[3] >>> Combine the progynosh script file to one fish shell script
              -argv[2] : the resource folder,default is the folder currently in
              -argv[3] : Set the name of output file,default is ./app

             console >>> An interactive console for progynosh dev

             get argv[2] >>> get libs from online repo
              -argv[2] : Name of the libs , view the list on github.com/happyeggchen/progynosh-script-source

             list argv[2] >>> listed installed libs
             -argv[2] : the resource folder,default is the folder currently in

             remove argv[2] argv[3] >>> remove mods from libs
              -argv[2] : the resource folder,default is the folder currently in
              -argv[3] : the name of mods

             push argv[2] >>> do a auto git push
              -argv[2] : comments you want to commit,remember to use a ''

             transfer argv[2] argv[3] >>> rebase your project to a newer progynosh version
              -argv[2] : version you want to transfer
                -Available : (1) candlelight -> cloudgirl (just set the argv[2] as "1")
                             (2) candlelight -> FrostFlower (just set the argv[2] as "2")
              -argv[3] : the project folder you want to trans,default is the folder currently in

            version >>> show the version of progynosh"
  echo "========================================"
end

function install
set installname $argv[1]
  set dir (realpath (dirname (status -f)))
  set filename (status --current-filename)
  chmod +x $dir/$filename
  sudo cp $dir/$filename /usr/bin/$installname
  set_color green
  echo "$prefix Installed"
  set_color normal
end
function uninstall
set installname $argv[1]
  sudo rm /usr/bin/$installname
  set_color green
  echo "$prefix Removed"
  set_color normal
end

function crescent-choose -d "draw a tui for choosing"
crescent-backend
set crescent_title $argv[1]
set crescent_title_menu $argv[2]
set crescent_menu_list $argv[3..-1]
if [ "$argv[1]" = "" ]
  set crescent_title crescent_title
end
if [ "$argv[2]" = "" ]
  set crescent_title_menu crescent_title_menu
end
set crescent_output ($crescent_backend --title $crescent_title --menu $crescent_title_menu 0 0 0 $crescent_menu_list 3>&1 1>&2 2>&3 3>&-)
echo $crescent_output
end
function crescent-gauge -d "progress bar"
crescent-backend
set crescent_title $argv[1]
set crescent_title_gauge $argv[2]
set crescent_gauge_percent $argv[3]
  if [ "$argv[1]" = "" ]
    set crescent_title crescent_title
  end
  if [ "$argv[2]" = "" ]
    set crescent_title_gauge crescent_title_gauge
  end
  if [ "$argv[3]" = "" ]
    set crescent_gauge_percent 0
  end
  echo $crescent_gauge_percent | $crescent_backend --title $crescent_title --gauge $crescent_title_gauge 0 0 0
end
function crescent-input -d "input box"
crescent-backend
set crescent_title $argv[1]
set crescent_title_input $argv[2]
set crescent_text_init $argv[3]
  if [ "$argv[1]" = "" ]
    set crescent_title crescent_title
  end
  if [ "$argv[2]" = "" ]
    set crescent_title_input crescent_title_input
  end
set crescent_output ($crescent_backend --title $crescent_title --inputbox $crescent_title_input 0 0 $crescent_text_init 3>&1 1>&2 2>&3 3>&-)
echo $crescent_output
end
function crescent-inputmenu -d "draw a tui for input"
crescent-backend
set crescent_title $argv[1]
set crescent_title_menu_text_input $argv[2]
set crescent_menu_list_text $argv[3..-1]
  if [ "$argv[1]" = "" ]
    set crescent_title crescent_title
  end
  if [ "$argv[2]" = "" ]
    set crescent_title_menu_text_input crescent_title_menu_text_input
  end
  set crescent_output ($crescent_backend --title $crescent_title --inputmenu $crescent_title_menu_text_input 0 0 0 $crescent_menu_list_text 3>&1 1>&2 2>&3 3>&-)
echo $crescent_output
end
function crescent-backend -d "detect backend for crescent"
  if command -q -v dialog
    set -g crescent_backend (command -v dialog)
  else
    if command -v whiptail
      set -g crescent_backend (command -v whiptail)
    else
    set_color red
    set_color normal
    end
  end
end
function crescent
switch $argv[1]
case choose
  crescent-choose $argv[2] $argv[3] $argv[4..-1]
case input
  crescent-input $argv[2] $argv[3] $argv[4]
case inputmenu
  crescent-inputmenu $argv[2] $argv[3] $argv[4..-1]
case gauge
  crescent-gauge $argv[2] $argv[3] $argv[4]
end
#trash collection
set -e crescent_backend
end

function build
  set build_time (date +"%Y-%m-%d_%T" -u)
  set resource_dir $argv[1]
  set build_output $argv[2]
  if [ "$argv[1]" = "" ]
    set resource_dir .
  end
  if [ "$argv[2]" = "" ]
    set build_output app
  end
  if test -d $resource_dir
    echo "$prefix Building from $resource_dir/"
  else
    set_color red
    set build_output $resource_dir
    set resource_dir .
    echo "$prefix No such resource folder found,process the argv as the output name,building from $resource_dir/"
  end
  if test -e $build_output
    set_color red
      echo "$prefix A file this name existed,delete it anyway?[y/n]"
    set_color normal
    read -n1 -P "$prefix >>> " _delete_var_
    switch $_delete_var_
    case Y y
      rm $build_output
    case N n '*'
      echo "$prefix Aborted"
	    exit
    end
  end
  for mod in (cat $resource_dir/configs/pynsh.mod)
    cat $resource_dir/libs/$mod >> $build_output
    echo >> $build_output
  end
  for blocks in (find $resource_dir/codes -type f | sed 's|^./||')
    cat $resource_dir/$blocks >> $build_output
    echo >> $build_output
  end
  if [ "$build_lib" = "1" ]
  else
    echo "echo Build_Time_UTC=$build_time" >> $build_output
  end
  cat $resource_dir/configs/main.fish >> $build_output
  chmod +x $build_output
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
echo "FrostFlower" > $resource_dir/configs/version.lock
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
    mkdir -p $resource_dir/res
    init-files $resource_dir
    echo "$prefix Deployed"
    set_color normal
  set -e resource_dir
end

function bundle -d "bundle data with script"
  set bundle_mode $argv[1]
  set resource_dir $argv[2]
  set bundle_output $argv[3]
  set bundle_data $argv[4]
  if [ "$bundle_mode" = "" ]
    set_color red
    echo "$prefix Unexpected Input in [app.progynosh.bundle_mode],{empty}"
    set_color normal
    exit
  end
  switch $bundle_mode
  case cui
    echo "$prefix Where the project located?{default: ./}"
    read -P "$prefix >>> " resource_dir
      if [ "$resource_dir" = "" ]
        set resource_dir .
      end
    echo "$prefix What name you want to give the produced file?{default: bundle_app}"
    read -P "$prefix >>> " bundle_output
      if [ "$bundle_output" = "" ]
        set bundle_output bundle_app
      end
    echo "$prefix Where the data folder located in?{default: res}"
    read -P "$prefix >>> " bundle_data
      if [ "$bundle_data" = "" ]
        set bundle_data res
      end
    set_color yellow
    echo "$prefix Bundling from $resource_dir"
    set_color normal
    mkdir -p $resource_dir/bundle_crafttable
    mv $resource_dir/$bundle_data $resource_dir/bundle_crafttable
    build $resource_dir $resource_dir/bundle_crafttable/bundle_app_core
    tar zcf bundle_data.tar.gz $resource_dir/bundle_crafttable/
    echo "#!/usr/bin/fish
set extract_time (date +"%Y-%m-%d_%T" -u)
mkdir progynosh_bundle_runtime\$extract_time
set dir (realpath (dirname (status -f)))
set filename (status --current-filename)
set startline (awk '/^progynosh_bundle_runtime_data_below/ {print NR + 1; exit 0; }' \$dir/\$filename)
tail -n+\$startline \$dir/\$filename | tar zxf - -C ./progynosh_bundle_runtime\$extract_time
cd progynosh_bundle_runtime\$extract_time/bundle_crafttable/
./bundle_app_core
rm -rf progynosh_bundle_runtime\$extract_time
exit 0
progynosh_bundle_runtime_data_below" > $resource_dir/$bundle_output
    cat $resource_dir/bundle_data.tar.gz >> $resource_dir/$bundle_output
    chmod +x $resource_dir/$bundle_output
    rm -f $resource_dir/bundle_data.tar.gz
    mv $resource_dir/bundle_crafttable/$bundle_data $resource_dir
    rm -rf $resource_dir/bundle_crafttable
    set_color green
    echo "$prefix Bundled"
    set_color normal
  case tui
    set resource_dir (crescent input 'Progynosh bundler' 'Where the project located?{default: ./}')
    if [ "$resource_dir" = "" ]
      set resource_dir .
    end
    set bundle_output (crescent input 'Progynosh bundler' 'What name you want to give the produced file?{default: bundle_app}')
    if [ "$bundle_output" = "" ]
      set bundle_output bundle_app
    end
    set bundle_data (crescent input 'Progynosh bundler' 'Where the data folder located in?{default: res}')
    if [ "$bundle_data" = "" ]
      set bundle_data res
    end
    set_color yellow
    crescent gauge 'Progynosh bundler' 'Building' 0
    set_color normal
    mkdir -p $resource_dir/bundle_crafttable
    crescent gauge 'Progynosh bundler' 'Building' 25
    mv $resource_dir/$bundle_data $resource_dir/bundle_crafttable
    build $resource_dir $resource_dir/bundle_crafttable/bundle_app_core
    crescent gauge 'Progynosh bundler' 'Building' 50
    tar zcf bundle_data.tar.gz $resource_dir/bundle_crafttable/*
    echo "#!/usr/bin/fish
set extract_time (date +"%Y-%m-%d_%T" -u)
mkdir progynosh_bundle_runtime\$extract_time
set dir (realpath (dirname (status -f)))
set filename (status --current-filename)
set startline (awk '/^progynosh_bundle_runtime_data_below/ {print NR + 1; exit 0; }' \$dir/\$filename)
tail -n+\$startline \$dir/\$filename | tar zxf - -C ./progynosh_bundle_runtime\$extract_time
cd progynosh_bundle_runtime\$extract_time/bundle_crafttable/
./bundle_app_core
rm -rf progynosh_bundle_runtime\$extract_time
exit 0
progynosh_bundle_runtime_data_below" > $resource_dir/$bundle_output
crescent gauge 'Progynosh bundler' 'Building' 76
    cat $resource_dir/bundle_data.tar.gz >> $resource_dir/$bundle_output
    crescent gauge 'Progynosh bundler' 'Building' 85
    chmod +x $resource_dir/$bundle_output
    crescent gauge 'Progynosh bundler' 'Building' 91
    rm -f $resource_dir/bundle_data.tar.gz
    crescent gauge 'Progynosh bundler' 'Building' 95
    mv $resource_dir/bundle_crafttable/$bundle_data $resource_dir
    crescent gauge 'Progynosh bundler' 'Building' 98
    rm -rf $resource_dir/bundle_crafttable
    crescent gauge 'Progynosh bundler' 'Building' 100
    echo
    set_color green
    echo "$prefix Bundled"
    set_color normal
  case h help '*'
    set_color red
    echo "$prefix Unexpected Input in [app.progynosh.bundle_mode],{$bundle_mode}"
    set_color normal
    exit
  end
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
    echo "CloudGirl" > $resource_dir/configs/version.lock
    dir_exist $resource_dir/codes
    dir_exist $resource_dir/libs
    set_color green
    echo "$prefix Done,your project had been rebased"
    set_color normal
end

function candlelight2frostflower -d "update the folder structure"
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
    echo "FrostFlower" > $resource_dir/configs/version.lock
    dir_exist $resource_dir/codes
    dir_exist $resource_dir/libs
    set_color green
    echo "$prefix Done,your project had been rebased"
    set_color normal
end

function fish_new -d "create a function"
set resource_dir $argv[1]
set newfishscript $argv[2]
if [ "$argv[1]" = "" ]
  set resource_dir .
end
if test -d $resource_dir
else
  set_color red
  set newfishscript $resource_dir
  set resource_dir .
  echo "$prefix No such resource folder found,process the argv as the name of new fish script,in $resource_dir/codes"
end
if [ "$newfishscript" = "" ]
  set_color red
    echo "$prefix Nothing to create,abort"
    exit
  set_color normal
else
  set newfishscriptbasename (basename $newfishscript)
  if test -e $resource_dir/codes/$newfishscript.fish
    set_color red
      echo "$prefix A file this name existed,delete it anyway?[y/n]"
    set_color normal
    read -n1 -P "$prefix >>> " _delete_var_
      switch $_delete_var_
      case Y y
        rm $resource_dir/codes/$newfishscript.fish
      case N n '*'
        echo "$prefix Aborted"
  	    exit
      end
  end
  if mkdir -p $resource_dir/codes/(dirname $newfishscript);printf "function $newfishscriptbasename\n\nend" > $resource_dir/codes/$newfishscript.fish
    set_color green
    echo "$prefix Processed and succeeded"
    set_color normal
  else
    set_color red
    echo "$prefix failed"
    set_color normal
  end
end
end

function remove -d "remove a mod from libs"
  set resource_dir $argv[1]
  set mod $argv[2]
  if [ "$argv[1]" = "" ]
    set resource_dir .
  end
  if test -d $resource_dir
    echo "$prefix removing libs from $resource_dir/libs"
  else
    set_color red
      echo "$prefix No such resource folder found,process the argv[3] as the mod name"
      set mod $resource_dir
      set resource_dir .
  end
  if test -e $resource_dir/libs/$mod
    if rm $resource_dir/libs/$mod
      set_color green
      echo "$prefix removed"
      set_color normal
    else
      set_color red
      echo "$prefix can't remove $mod,abort"
      set_color normal
    end
  else
    set_color red
    echo "$prefix Nothing to remove,abort"
    set_color normal
  end
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
  if curl -o $modulename -s -L "https://github.com/happyeggchen/progynosh-script-source/raw/main/$modulename/$modulename"
  set_color green
  echo "$prefix Processed and succeeded"
  set_color normal
  else
  set_color red
  echo "$prefix failed"
  set_color normal
  end
  cd ..
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

function console
while [ 0 = 0 ]
read -P "[Progynosh Console] >>> " console_opt -a
  switch $console_opt[1]
  case install
    install progynosh
  case uninstall
    uninstall progynosh
  case init
    init $console_opt[2]
  case build
    if [ "$console_opt[2]" = "-l" ]
      set -lx build_lib 1
      build $console_opt[3] $console_opt[4]
    else
      set -lx build_lib 0
      build $console_opt[2] $console_opt[3]
    end
  case bundle
    bundle $console_opt[2] $console_opt[3] $console_opt[4] $console_opt[5]
  case get
    get $console_opt[2]
  case list
    list $console_opt[2]
  case remove
    remove $console_opt[2] $console_opt[3]
  case push
    push $console_opt[2]
  case transfer
    switch $console_opt[2]
    case 1
      candlelight2cloudgirl $console_opt[3]
    case 2
      candlelight2frostflower $console_opt[3]
    case h help '*'
      set_color red
      echo "$prefix Unexpected input in [transfer.progynosh]{$console_opt[1]}"
      set_color normal
    end
  case new
    fish_new $console_opt[2] $console_opt[3]
  case console
    console
  case v version
    set_color yellow
    echo "FrostFlower@build5"
    set_color normal
  case exit
    exit
  case h help
    help_echo
  case p '*'
    $console_opt[1..-1]
  end
end
end

function list -d "list mods"
set -g resource_dir $argv[1]
  if [ "$argv[1]" = "" ]
    set -g resource_dir .
  end
ls $resource_dir/libs | sed '\~//~d'
end

echo Build_Time_UTC=2022-01-02_05:17:18
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
  if [ "$argv[2]" = "-l" ]
    set -lx build_lib 1
    build $argv[3] $argv[4]
  else
    set -lx build_lib 0
    build $argv[2] $argv[3]
  end
case bundle
  bundle $argv[2] $argv[3] $argv[4] $argv[5]
case get
  get $argv[2]
case list
  list $argv[2]
case remove
  remove $argv[2] $argv[3]
case push
  push $argv[2]
case transfer
  switch $argv[2]
  case 1
    candlelight2cloudgirl $argv[3]
  case 2
    candlelight2frostflower $argv[3]
  case h help '*'
    set_color red
    echo "$prefix Unexpected input in [transfer.progynosh]{$argv[1]}"
    set_color normal
  end
case new
  fish_new $argv[2] $argv[3]
case console
  console
case v version
  set_color yellow
  echo "FrostFlower@build5"
  set_color normal
case h help '*'
  help_echo
end
