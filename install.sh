#!/usr/bin/env bash
# shellcheck disable=SC2068,SC2046,SC2086

cd $(dirname $(realpath $0)) || exit

pkg=(
    acpid                           # (extra)       acpi event daemon
    # alacritty                       # (extra)       terminal
    betterlockscreen                # (aur)         i3 lock screen
    blueman                         # (extra)       bluetooth manager
    bluez                           # (extra)       bluetooth
    bluez-utils                     # (extra)       bluetooth
    cdw                             # (aur)         optical disk drive cli
    code                            # (extra)       ide
    code-features                   # (aur)         vscode extensions dependencies
    code-marketplace                # (aur)         vscode extensions
    cups                            # (extra)       open printing daemon package
    dbus-python                     # (extra)       python bindings for dbus
    discord                         # (extra)       chat
    dunst                           # (extra)       notification daemon
    eww-git                         # (aur)         widget system
    feh                             # (extra)       image viewer
    ffmpeg                          # (extra)       media conversion
    firefox                         # (extra)       web browser
    font-manager                    # (extra)       font viewer/manager
    fzf                             # (extra)       fuzzy finder
    gnome-keyring                   # (extra)       org.freedesktop.secrets keyring daemon
    highlight                       # (extra)       code highlighting (for ranger)
    i3-wm                           # (extra)       window manager
    i3lock-color                    # (aur)         i3 lock screen (used by betterlockscreen)
    inter-font                      # (extra)       font for user interfaces
    kermit                          # (aur)         terminal with bidi support
    khal                            # (extra)       calendar
    kitty                           # (extra)       terminal
    libnotify                       # (extra)       notification events
    maim                            # (extra)       screen capture
    mobile-broadband-provider-info  # (extra)       mobile broadband APN config presets
    modemmanager                    # (extra)       mobile broadband modem management
    mpv                             # (extra)       media player
    neofetch                        # (extra)       system information
    neovim                          # (extra)       text editor
    networkmanager                  # (extra)       network connection manager
    network-manager-applet          # (extra)       network manager tray applet
    noto-fonts                      # (extra)       google font family
    noto-fonts-cjk                  # (extra)       chinese/japanese/korean
    noto-fonts-emoji                # (extra)       emoji
    noto-fonts-extra                # (extra)       additional variants
    npm                             # (extra)       package manager for javascript
    ntfs-3g                         # (extra)       ntfs partition support
    opensiddur-hebrew-fonts         # (aur)         open source hebrew font pack
    picom                           # (extra)       window compositor
    pipewire                        # (extra)       audio/video processor
    pipewire-alsa                   # (extra)       alsa replacement for pipewire
    pipewire-jack                   # (extra)       jack support for pipewire
    pipewire-pulse                  # (extra)       pulseaudio replacement for pipewire
    polybar                         # (extra)       status bars
    powerline-fonts                 # (extra)       fonts for zsh-theme-powerlevel10k
    pyright                         # (extra)       python LSP (for nvim)
    python-gobject                  # (extra)       python bindings for glib/gobject
    python-pip                      # (extra)       python package manager
    python-pipx                     # (extra)       python isolated packages
    python-watchdog                 # (extra)       python api for inotify
    ranger                          # (extra)       file browser cli
    rofi                            # (extra)       menus
    ruff                            # (extra)       python linter
    seahorse                        # (extra)       gnome keyring manager
    speedtest-cli                   # (extra)       network speed test
    steam                           # (multilib)    games
    taskwarrior-tui                 # (extra)       task list
    translate-shell                 # (extra)       translate cli
    ttf-font-awesome                # (extra)       font awesome
    ttf-fira-code                   # (extra)       fira font
    # ttf-iosevka-nerd                # (extra)       iosevka font (patched with nerd fonts)
    ttf-jetbrains-mono              # (extra)       jetbrains font
    ttf-jetbrains-mono-nerd         # (extra)       jetbrains nerd font
    ttf-material-design-icons       # (aur)         material design icons font
    udiskie                         # (extra)       disk automount
    ueberzug                        # (extra)       display image in cli
    unzip                           # (extra)       unzip utility
    usbutils                        # (core)        usb tools
    usb_modeswitch                  # (extra)       usb activation
    wireplumber                     # (extra)       pipewire client
    xidlehook                       # (aur)         autolock
    xclip                           # (extra)       clipboard
    xdotool                         # (extra)       key/mouse/window fake activity
    xdg-desktop-portal              # (extra)       desktop integration for sandboxed apps
    zathura                         # (extra)       document viewer
    zathura-pdf-mupdf               # (extra)       zathura plugin for pdf
    zip                             # (extra)       zip utility
    zsh                             # (extra)       shell
    zsh-autosuggestions             # (extra)       suggestions for zsh
    zsh-syntax-highlighting         # (extra)       syntax highlighting for zsh
    zsh-theme-powerlevel10k         # (extra)       zsh theme
)

pkg_py=(
    vdirsyncer                      # (extra)       caldav/carddav sync
)

services=(
    ModemManager.service                # modem/mobile network
    NetworkManager.service              # network
    acpid.service                       # battery
    bluetooth.service                   # bluetooth
    "betterlockscreen@$USER.service"    # betterlockscreen
)

# install yay
(
    sudo pacman -S git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si
    cd ..
    rm -rf yay
)

yay -Syu ${pkg[@]}

systemctl enable ${services[@]}
systemctl start ${services[@]}

for pypkg in ${pkg_py[@]}
do
    pipx install $pypkg
done

# X11 Keymap
# us/il layouts, toggle layout with alt+shift, map caps lock to ctrl
# use setxkbmap for more options
localectl set-x11-keymap us,il grp:alt_shift_toggle caps:ctrl_modifier

chsh -s /bin/zsh

# install NvChad
mv -v ~/.config/nvim ~/.config/nvim-backup
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# link user files
cp -aflv home/.*[^.] $HOME/

# set background
feh --bg-fill ~/.local/share/backgrounds/wallhaven-q2pxml.png
# set lock screen background
betterlockscreen -u ~/.local/share/backgrounds/wallhaven-q2pxml.png

# show grub matter theme suggestion
echo "suggestion: grub matter theme"
echo "    git clone https://github.com/mateosss/matter.git"
echo "    install inkscape (extra)"
echo "    sudo python matter.py"
echo "    in case of resolution mismatch edit /etc/default/grub GRUB_GFXMODE then update grub"
