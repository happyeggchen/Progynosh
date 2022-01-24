function get -d "get libs from online repo"
    if [ "$argv" = "" ]
        logger 4 "Unexpect input at [get.progynosh]{empty}"
        exit
    end
    for target_module in $argv
        cd libs
        if curl -o $target_module -s -L "https://github.com/happyeggchen/progynosh-script-source/raw/main/$target_module/$target_module"
            logger 1 "Processed and succeeded"
        else
            logger 0 "Failed"
        end
        cd ..
        echo $target_module >> configs/pynsh.mod
    end
end
