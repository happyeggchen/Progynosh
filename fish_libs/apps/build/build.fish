function build
  set -g build_time (date +"%Y-%m-%d_%T" -u)
  set -g build_output $argv[1]
  if [ "$argv[1]" = "" ]
    set -g build_output app
  end
  function app_fish_empty
    if test -e $build_output
      set_color red
        echo "[Progynosh]A file this name existed,delete it anyway?[y/n]"
      set_color normal
      read -P "[Progynosh] >>> " _delete_var_
      switch $_delete_var_
      case y
        rm $build_output
      case n '*'
        echo "[Progynosh]Aborted"
	      exit
      end
    end
  end
  app_fish_empty
  for mod in (cat pynsh.mod)
    cat fish_libs/libs/$mod >> $build_output
  end
  for dir_select in (ls fish_libs/apps/)
    if test -d fish_libs/apps/$dir_select
      set dir_select_empty (ls fish_libs/apps/$dir_select 2&>/dev/null)
      if [ "$dir_select_empty" = "" ]
      else
        cat fish_libs/apps/$dir_select/** >> $build_output
      end
    else
      cat fish_libs/apps/$dir_select >> $build_output
    end
  end
  echo "set_color yellow
  echo Build_Time_UTC=$build_time
  set_color normal" >> $build_output
  cat fish_libs/main.fish >> $build_output
  chmod +x $build_output
  set -e build_output
  set_color green
  echo "[Progynosh]Built"
  set_color normal
end
