# https://wiki.archlinux.org/title/XDG_Base_Directory#Specification

set -q XDG_DATA_HOME    || set -U XDG_DATA_HOME     $HOME/.local/share
set -q XDG_CONFIG_HOME  || set -U XDG_CONFIG_HOME   $HOME/.config
set -q XDG_STATE_HOME   || set -U XDG_STATE_HOME    $HOME/.local/state
set -q XDG_CACHE_HOME   || set -U XDG_CACHE_HOME    $HOME/.cache
set -q XDG_RUNTIME_DIR  || set -U XDG_RUNTIME_DIR   $HOME/.xdg
