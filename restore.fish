#!/usr/bin/fish

set -l this_script (status filename | path resolve)

echo "Me: $this_script"

set -l this_scrip_dir (path dirname $this_script)

echo "My dir: $this_scrip_dir"

set -l config_target ~/.config
set -l fish_scripts  (find $this_script_dir -name \*.fish | path normalize)

echo "Fish  scripts: $fish_scripts"

for cfg in $fish_scripts
    set -l dst "$config_target/$cfg"
    install -v -C -D $cfg $dst
end
