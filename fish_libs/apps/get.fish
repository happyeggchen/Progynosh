function get -d "get libs from online repo"
  set -g modulename $argv[1]
  if [ "$argv[1]" = "" ]
    set_color red
    echo "[progynosh]Unexpect input"
    set_color normal
    exit
  end
  cd fish_libs/libs
  wget "https://github.com/happyeggchen/progynosh-script-source/raw/main/$modulename/$modulename"
  set_color cyan
  echo "[progynosh]Processed"
  set_color normal
end
