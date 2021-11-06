function init
  checkdependence /usr/bin/curl
  checkdependence /usr/bin/tar
  dir_exist ~/.cache/progynosh
  if test -e ~/.cache/progynosh/structure.tar
    tar xf ~/.cache/progynosh/structure.tar
    set_color green
    echo "[Progynosh]Deployed"
    set_color normal
  else
    set_color red
    echo "[Progynosh]No structure cached,fetching"
    set_color normal
    curl -s -o ~/.cache/progynosh/structure.tar 'https://tsingkwai.ruzhtw.top/files/progynosh/progynosh.tar'
    set_color yellow
    echo "[Progynosh]Fetched structure tar"
    set_color normal
    tar xf ~/.cache/progynosh/structure.tar
    set_color green
    echo "[Progynosh]Deployed"
    set_color normal
  end
end
