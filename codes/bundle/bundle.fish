function bundle -d "bundle data with script"
  set bundle_mode $argv[1]
  set resource_dir $argv[2]
  set bundle_output $argv[3]
  set bundle_data $argv[4]
  if [ "$bundle_mode" = "" ]
    logger 4 "$prefix Unexpected Input in [bundle_mode.progynosh],{empty}"
    exit
  end
  switch $bundle_mode
  case cui
    logger 0 "$prefix Where the project located?{default: ./}"
    read -P "$prefix >>> " resource_dir
      if [ "$resource_dir" = "" ]
        set resource_dir .
      end
    logger 0 "$prefix What name you want to give the produced file?{default: bundle_app}"
    read -P "$prefix >>> " bundle_output
      if [ "$bundle_output" = "" ]
        set bundle_output bundle_app
      end
    logger 0 "$prefix Where the data folder located in?{default: res}"
    read -P "$prefix >>> " bundle_data
      if [ "$bundle_data" = "" ]
        set bundle_data res
      end
    logger 0 "$prefix Bundling from $resource_dir"
    mkdir -p $resource_dir/bundle_crafttable
    cp -r $resource_dir/$bundle_data $resource_dir/bundle_crafttable
    build $resource_dir $resource_dir/bundle_crafttable/bundle_app_core
    cp /usr/bin/fish $resource_dir/bundle_crafttable/fish
    chmod +x $resource_dir/bundle_crafttable/fish
    tar zcf bundle_data.tar.gz $resource_dir/bundle_crafttable/
    echo '#!/usr/bin/bash
extract_time=$(date +"%Y-%m-%d_%T" -u)
mkdir progynosh_bundle_runtime$extract_time
startline=`awk \'/^progynosh_bundle_runtime_data_below/ {print NR + 1; exit 0; }\' $0`
tail -n+$startline $0 | tar zxf - -C ./progynosh_bundle_runtime$extract_time
cd progynosh_bundle_runtime$extract_time/bundle_crafttable/ && ./fish bundle_app_core && cd ../../
rm -rf ./progynosh_bundle_runtime$extract_time
exit 0
progynosh_bundle_runtime_data_below' > $resource_dir/$bundle_output
    cat $resource_dir/bundle_data.tar.gz >> $resource_dir/$bundle_output
    chmod +x $resource_dir/$bundle_output
    rm -f $resource_dir/bundle_data.tar.gz
    rm -rf $resource_dir/bundle_crafttable
    logger 1 "Bundled"
  case tui
    set resource_dir (crescent input 'Progynosh bundler' 'Where the project located?{default: ./}')
    if [ "$resource_dir" = "" ]
      set resource_dir .
    end
    set bundle_output (crescent input 'Progynosh bundler' 'What name you want to give the produced file?{default: bundle_app}')
    if [ "$bundle_output" = "" ]
      set bundle_output bundle_app
    end
    set bundle_data (crescent input 'Progynosh bundler' 'Where the data folder located in?{default: res}')
    if [ "$bundle_data" = "" ]
      set bundle_data res
    end
    crescent gauge 'Progynosh bundler' 'Building' 0
    mkdir -p $resource_dir/bundle_crafttable
    crescent gauge 'Progynosh bundler' 'Building' 25
    cp -r $resource_dir/$bundle_data $resource_dir/bundle_crafttable
    build $resource_dir $resource_dir/bundle_crafttable/bundle_app_core
    cp /usr/bin/fish $resource_dir/bundle_crafttable/fish
    chmod +x $resource_dir/bundle_crafttable/fish
    crescent gauge 'Progynosh bundler' 'Building' 50
    tar zcf bundle_data.tar.gz $resource_dir/bundle_crafttable/*
    echo '#!/usr/bin/bash
extract_time=$(date +"%Y-%m-%d_%T" -u)
mkdir progynosh_bundle_runtime$extract_time
startline=`awk \'/^progynosh_bundle_runtime_data_below/ {print NR + 1; exit 0; }\' $0`
tail -n+$startline $0 | tar zxf - -C ./progynosh_bundle_runtime$extract_time
cd progynosh_bundle_runtime$extract_time/bundle_crafttable/ && ./fish bundle_app_core && cd ../../
rm -rf ./progynosh_bundle_runtime$extract_time
exit 0
progynosh_bundle_runtime_data_below' > $resource_dir/$bundle_output
crescent gauge 'Progynosh bundler' 'Building' 76
    cat $resource_dir/bundle_data.tar.gz >> $resource_dir/$bundle_output
    crescent gauge 'Progynosh bundler' 'Building' 85
    chmod +x $resource_dir/$bundle_output
    crescent gauge 'Progynosh bundler' 'Building' 91
    rm -f $resource_dir/bundle_data.tar.gz
    crescent gauge 'Progynosh bundler' 'Building' 95
    rm -rf $resource_dir/bundle_crafttable
    crescent gauge 'Progynosh bundler' 'Building' 98
    crescent gauge 'Progynosh bundler' 'Building' 100
    echo
    logger 1 "Bundled"
  case h help '*'
    logger 4 "$prefix Unexpected Input in [bundle_mode.progynosh],{$bundle_mode}"
    exit
  end
end
