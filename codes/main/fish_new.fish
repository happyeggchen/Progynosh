function fish_new -d "create a function"
set resource_dir $argv[1]
set newfishscript $argv[2]
if [ "$argv[1]" = "" ]
  set resource_dir .
end
if test -d $resource_dir
else
  set newfishscript $resource_dir
  set resource_dir .
  logger 3 "No such resource folder found,process the argv as the name of new fish script,in $resource_dir/codes"
end
if [ "$newfishscript" = "" ]
    logger 4 "Nothing to create,abort"
    exit
  set_color normal
else
  set newfishscriptbasename (basename $newfishscript)
  if test -e $resource_dir/codes/$newfishscript.fish
      logger 3 "A file this name existed,delete it anyway?[y/n]"
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
    logger 1 "Processed and succeeded"
  else
    logger 4 "$prefix failed"
  end
end
end
