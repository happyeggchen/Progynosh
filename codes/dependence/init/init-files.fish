function init-files -d "write essential content to structure files"
    set resource_dir $argv[1]
    echo header >$resource_dir/configs/pynsh.mod
    echo "#!/usr/bin/env fish" >$resource_dir/libs/header
    echo "" >$resource_dir/docs/LICENSE
    echo 'A progynosh fish script doc
===========================
This is a script dev manager for fish script shell
>>>>> How To <<<<<
	1 >	write your script as functions in $resource_dir/codes
	2 >	call them from $resource_dir/configs/main.fish
	3 >	use progynosh build to build a final fish script' >$resource_dir/docs/handbook.md
echo 'function checkdependence
set 34ylli8_deps_ok 1
for 34ylli8_deps in $argv
    if command -q -v $34ylli8_deps
    else
        set 34ylli8_deps_ok 0
        if test -z "$34ylli8_dep_lost"
            set 34ylli8_deps_lost "$34ylli8_deps $34ylli8_deps_lost"
        else
            set 34ylli8_deps_lost "$34ylli8_deps"
        end
    end
end
if test "$34ylli8_deps_ok" -eq 0
    set_color red
    echo "$prefix [error] Please install "$34ylli8_deps_lost"to run this program"
    set_color normal
    exit
end
end
function checknetwork
  if curl -s -L $argv[1] | grep -q $argv[2]
  else
    set_color red
    echo "$prefix [error] [checknetwork] check failed - check your network connection"
    set_color normal
  end
end
function dir_exist
  if test -d $argv[1]
  else
    set_color red
    echo "$prefix [error] [checkdir] check failed - dir $argv[1] doesn\'t exist,going to makr one"
    set_color normal
    mkdir $argv[1]
  end
end
function list_menu
ls $argv | sed \'\~//~d\'
end' >$resource_dir/libs/base
    echo 'set -lx prefix 
switch $argv[1]
end' >$resource_dir/configs/main.fish
    echo BlackDeath >$resource_dir/configs/version.lock
end
