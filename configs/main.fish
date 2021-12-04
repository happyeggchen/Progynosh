set prefix "[Progynosh]"
set_color cyan
echo "$prefix progynosh fish shell script dev manager | by tsingkwai@protonmail.com (tsingkwai.ruzhtw.top)"
set_color normal
switch $argv[1]
case install
  install progynosh
case uninstall
  uninstall progynosh
case init
  init $argv[2]
case build
  build $argv[2] $argv[3]
case bundle
  bundle $argv[2] $argv[3] $argv[4] $argv[5]
case get
  get $argv[2]
case list
  list $argv[2]
case remove
  remove $argv[2] $argv[3]
case push
  push $argv[2]
case transfer
  switch $argv[2]
  case 1
    candlelight2cloudgirl $argv[3]
  case 2
    candlelight2frostflower $argv[3]
  case h help '*'
    set_color red
    echo "$prefix Unexpected input in [app.progynosh.transfer.MainActivity]{$argv[1]}"
    set_color normal
  end
case v version
  set_color yellow
  echo "FrostFlower@build1"
  set_color normal
case h help '*'
  help_echo
end
