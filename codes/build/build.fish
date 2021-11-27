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
      echo "$prefix No such resource folder found,process the argv as the output name,building from $resource_dir/"
      set build_output $resource_dir
      set resource_dir .
  end
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
  set_color green
  echo "$prefix Built"
  set_color normal
end
