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
        if [ "$argv[2]" = -l ]
            set -lx build_lib 1
            build $argv[3] $argv[4]
        else
            set -lx build_lib 0
            build $argv[2] $argv[3]
        end
    case bundle
        bundle $argv[2] $argv[3] $argv[4] $argv[5]
    case get
        get $argv[2..-1]
    case list
        list $argv[2]
    case remove
        remove $argv[2] $argv[3..-1]
    case push
        push $argv[2]
    case transfer
        switch $argv[2]
            case 1
                candlelight2cloudgirl $console_opt[3]
            case 2
                candlelight2frostflower $console_opt[3]
            case 3
                frostflower2blackdeath $console_opt[3]
            case h help '*'
                logger 4 "Unexpected input in [transfer.progynosh]{$console_opt[1]}"
        end
    case new
        fish_new $argv[2] $argv[3]
    case console
        console
    case v version
        logger 0 "BlackDeath@build1"
    case h help '*'
        help_echo
end
