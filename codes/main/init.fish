function init
  set -g resource_dir $argv[1]
  if [ "$argv[1]" = "" ]
    set -lx resource_dir .
  end
    mkdir -p $resource_dir/codes
    mkdir -p $resource_dir/configs
    mkdir -p $resource_dir/docs
    mkdir -p $resource_dir/libs
    mkdir -p $resource_dir/res
    init-files $resource_dir
    logger 1 "Deployed"
end
