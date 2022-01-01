function console
while [ 0 = 0 ]
read -P "[Progynosh Console] >>> " console_opt -a
  switch $console_opt[1]
  case install
    install progynosh
  case uninstall
    uninstall progynosh
  case init
    init $console_opt[2]
  case build
    if [ "$console_opt[2]" = "-l" ]
      set -lx build_lib 1
      build $console_opt[3] $console_opt[4]
    else
      set -lx build_lib 0
      build $console_opt[2] $console_opt[3]
    end
  case bundle
    bundle $console_opt[2] $console_opt[3] $console_opt[4] $console_opt[5]
  case get
    get $console_opt[2]
  case list
    list $console_opt[2]
  case remove
    remove $console_opt[2] $console_opt[3]
  case push
    push $console_opt[2]
  case transfer
    switch $console_opt[2]
    case 1
      candlelight2cloudgirl $console_opt[3]
    case 2
      candlelight2frostflower $console_opt[3]
    case h help '*'
      set_color red
      echo "$prefix Unexpected input in [transfer.progynosh]{$console_opt[1]}"
      set_color normal
    end
  case new
    fish_new $console_opt[2] $console_opt[3]
  case console
    console
  case v version
    set_color yellow
    echo "FrostFlower@build5"
    set_color normal
  case exit
    exit
  case h help
    help_echo
  case p '*'
    $console_opt[1..-1]
  end
end
end
