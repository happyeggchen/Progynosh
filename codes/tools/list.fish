function list -d "list mods"
set -g resource_dir $argv[1]
  if [ "$argv[1]" = "" ]
    set -g resource_dir .
  end
ls $resource_dir/libs | sed '\~//~d'
end
