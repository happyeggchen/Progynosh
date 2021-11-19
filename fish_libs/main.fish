set_color cyan
echo "[Progynosh]progynosh fish shell script dev manager | by tsingkwai@protonmail.com (tsingkwai.ruzhtw.top)"
set_color normal
switch $argv[1]
case install
  install
case uninstall
  uninstall
case init
  init
case build
  build $argv[2]
case get
  get $argv[2]
case push
  push $argv[2]
case h help '*'
  help_echo
end
