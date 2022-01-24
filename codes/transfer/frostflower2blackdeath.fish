function frostflower2blackdeath
    set resource_dir $argv[1]
    if [ "$argv[1]" = "" ]
        set resource_dir '.'
    end
    if test (cat $resource_dir/configs/version.lock) = FrostFlower; or test (cat $resource_dir/configs/version.lock) = cloudgirl; or test (cat $resource_dir/configs/version.lock) = CloudGirl
    else
        logger 4 "Only FrostFlower or cloudgirl can be transferred to BlackDeath,are you sure the sturcture of your project meet the requirment?"
        read -n1 -P "$prefix >>> " _version_check_
        switch $_version_check_
            case Y y
            case N n '*'
                logger 0 Aborted
                exit
        end
    end
    logger 0 "Start rebasing your project at "$resource_dir""
    logger 0 'Upgrading the base script package...'
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
    echo "$prefix [error] "Please install "$34ylli8_deps_lost"to run this program""
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
ls $argv | sed '\~//~d'
end' >$resource_dir/libs/base
    echo BlackDeath >$resource_dir/configs/version.lock
    logger 1 Done
end
