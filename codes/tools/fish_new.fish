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
  if mkdir -p $resource_dir/codes/(dirname $newfishscript);printf "function $newfishscriptbasename\nend" > $resource_dir/codes/$newfishscript.fish
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
