function remove -d "remove a mod from libs"
    set resource_dir $argv[1]
    set mod $argv[2..-1]
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    if test -d $resource_dir
        logger 1 "Removing libs from $resource_dir/libs"
    else
        set_color red
        logger 3 "Resource folder $resource_dir not found,processing the argv[3] as the mod name"
        set mod $resource_dir
        set resource_dir .
    end
    for target_module in $mod
        if test -e $resource_dir/libs/$target_module
            if rm $resource_dir/libs/$target_module
                logger 1 Removed
            else
                logger 4 "Can't remove $mod,abort"
            end
        else
            logger 4 "Nothing to remove,abort"
        end
    end
end
