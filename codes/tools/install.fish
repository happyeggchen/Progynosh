function install
set dir (realpath (dirname (status -f)))
set filename (status --current-filename)
chmod +x $dir/$filename
sudo cp $dir/$filename /usr/bin/progynosh
set_color green
echo "$prefix Installed"
set_color normal
end
