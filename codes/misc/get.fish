function get -d "get libs from online repo"
    if [ "$argv" = "" ]
        logger 4 "Unexpect input at [get.progynosh]{empty}"
        exit
    end
    for target_module in $argv
        cd libs
        if curl -o $target_module -s -L "https://github.com/happyeggchen/progynosh-script-source/raw/main/$target_module/$target_module"
            if cat "$target_module" | head -n2 | grep -qs function
            logger 1 "Library -> $target_module installed"
            else
                logger 4 "Failed to install library -> $target_module, check the name and network, then try again"
            end
        else
            logger 4 "Failed to install library -> $target_module, check the name and network, then try again"
        end
        cd ..
        if grep -qs $target_module configs/pynsh.mod
        else
            echo $target_module >>configs/pynsh.mod
        end
    end
end
