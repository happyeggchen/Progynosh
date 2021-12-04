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
