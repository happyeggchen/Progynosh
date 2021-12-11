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
