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
