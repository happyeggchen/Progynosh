function build
    set build_time (date +"%Y-%m-%d_%T" -u)
    set resource_dir $argv[1]
    set build_output $argv[2]
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    if [ "$argv[2]" = "" ]
        set build_output app
    end
    if test -d $resource_dir
        echo "$prefix Building from $resource_dir/"
    else
        set build_output $resource_dir
        set resource_dir .
        logger 3 "Resource folder $resource_dir not found,processing the argv[2] as the output name,building from $resource_dir/"
    end
    if test -e $build_output
        logger 3 "$prefix A file this name has existed,delete it anyway?[y/n]"
        read -n1 -P "$prefix >>> " _delete_var_
        switch $_delete_var_
            case Y y
                rm $build_output
            case N n '*'
                logger 0 "Aborted"
                exit
        end
    end
    for mod in (cat $resource_dir/configs/pynsh.mod)
        cat $resource_dir/libs/$mod >>$build_output
        echo >>$build_output
    end
    for blocks in (find $resource_dir/codes -type f | sed 's|^./||')
        cat $resource_dir/$blocks >>$build_output
        echo >>$build_output
    end
    if [ "$build_lib" = 1 ]
    else
        echo "echo Build_Time_UTC=$build_time" >>$build_output
    end
    cat $resource_dir/configs/main.fish >>$build_output
    chmod +x $build_output
    logger 1 Built
end
