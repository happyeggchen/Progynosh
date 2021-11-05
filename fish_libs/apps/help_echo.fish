function help_echo
  set_color cyan
  echo "Progynosh fish script build system | RuzhTaiWan [R] 2017-2021"
  set_color normal
  echo "==========Help Documentation=========="
  set_color green
  echo "(./)progynosh argv[1]"
  set_color normal
  echo " -argv[1]:the command to execute"
  echo "  -Available:
             install >>> install to /usr/bin
             uninstall >>> remove from /usr/bin
             init >>> Download and deploy the core file and structure for pynsh
             build argv[2] >>> Combine the progynosh script file to one fish shell script
              -argv[2] : Set the name of output file
             get argv[2] >>> get libs from online repo
              -argv[2] : Name of the libs , view the list on github.com/bluelakelab/progynosh-script-source"
  set_color yellow
  echo "Remember,do this in the project dir,otherwish your root dir will full of pynsh files"
  set_color normal
  echo "========================================"
end
