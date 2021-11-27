function get -d "get libs from online repo"
  set -g modulename $argv[1]
  if [ "$argv[1]" = "" ]
    set_color red
    echo "$prefix Unexpect input"
    set_color normal
    exit
  end
  cd libs
  if curl -o $modulename -s -L "https://github.com/happyeggchen/progynosh-script-source/raw/main/$modulename/$modulename"
  set_color green
  echo "$prefix Processed and succeeded"
  set_color normal
  else
  set_color red
  echo "$prefix failed"
  set_color normal
  end
end
