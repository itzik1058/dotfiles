# https://wiki.archlinux.org/title/XDG_Base_Directory#Specification

set -q XDG_CACHE_HOME   || set -U XDG_CACHE_HOME    $HOME/.cache
set -q XDG_CONFIG_HOME  || set -U XDG_CONFIG_HOME   $HOME/.config
set -q XDG_DATA_HOME    || set -U XDG_DATA_HOME     $HOME/.local/share
set -q XDG_RUNTIME_DIR  || set -U XDG_RUNTIME_DIR   $HOME/.xdg

switch (uname)
    case Linux
        set -q XDG_DESKTOP_DIR      || set -U XDG_DESKTOP_DIR       "$HOME/Desktop"
        set -q XDG_DOCUMENTS_DIR    || set -U XDG_DOCUMENTS_DIR     "$HOME/Documents"
        set -q XDG_DOWNLOAD_DIR     || set -U XDG_DOWNLOAD_DIR      "$HOME/Downloads"
        set -q XDG_MUSIC_DIR        || set -U XDG_MUSIC_DIR         "$HOME/Music"
        set -q XDG_PICTURES_DIR     || set -U XDG_PICTURES_DIR      "$HOME/Pictures"
        set -q XDG_PUBLICSHARE_DIR  || set -U XDG_PUBLICSHARE_DIR   "$HOME/Public"
        set -q XDG_TEMPLATES_DIR    || set -U XDG_TEMPLATES_DIR     "$HOME/Templates"
        set -q XDG_VIDEOS_DIR       || set -U XDG_VIDEOS_DIR        "$HOME/Videos"
end
