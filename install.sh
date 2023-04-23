#!/usr/bin/env bash
# shellcheck disable=SC2068,SC2046,SC2086

cd $(dirname $(realpath $0)) || exit

pkg=(
    acpi                            # (community)   battery status
    acpid                           # (community)   acpi event daemon
    alacritty                       # (community)   terminal
    blueman                         # (community)   bluetooth manager
    bluez                           # (extra)       bluetooth
    bluez-utils                     # (extra)       bluetooth
    code                            # (community)   ide
    code-features                   # (aur)         vscode extensions dependencies
    code-marketplace                # (aur)         vscode extensions
    discord                         # (community)   chat
    dunst                           # (community)   notification daemon
    eww                             # (aur)         widget system
    ffmpeg                          # (extra)       media conversion
    firefox                         # (extra)       web browser
    fish                            # (community)   shell
    font-manager                    # (community)   font viewer/manager
    github-desktop-bin              # (aur)         github desktop
    gnome-keyring                   # (extra)       org.freedesktop.secrets keyring daemon
    i3-wm                           # (community)   window manager
    kermit                          # (aur)         terminal with bidi support
    khal                            # (community)   calendar
    libnotify                       # (extra)       notification events
    maim                            # (community)   screen capture
    mobile-broadband-provider-info  # (extra)       mobile broadband APN config presets
    modemmanager                    # (extra)       mobile broadband modem management
    neofetch                        # (community)   system information
    neovim                          # (community)   text editor
    networkmanager                  # (extra)       network connection manager
    network-manager-applet          # (extra)       network manager tray applet
    nitrogen                        # (extra)       image viewer
    noto-fonts                      # (extra)       google font family
    noto-fonts-cjk                  # (extra)       chinese/japanese/korean
    noto-fonts-emoji                # (extra)       emoji
    noto-fonts-extra                # (extra)       additional variants
    ntfs-3g                         # (extra)       ntfs partition support
    opensiddur-hebrew-fonts         # (aur)         open source hebrew font pack
    picom                           # (community)   window compositor
    pipewire                        # (extra)       audio/video processor
    pipewire-alsa                   # (extra)       alsa replacement for pipewire
    pipewire-jack                   # (extra)       jack support for pipewire
    pipewire-pulse                  # (extra)       pulseaudio replacement for pipewire
    polybar                         # (community)   status bars
    python-pipx                     # (community)   python isolated packages
    ranger                          # (community)   file browser cli
    rofi                            # (community)   menus
    seahorse                        # (extra)       gnome keyring manager
    steam                           # (multilib)    games
    taskwarrior-tui                 # (community)   task list
    translate-shell                 # (community)   translate cli
    ttf-font-awesome                # (community)   icon library
    ttf-fira-code                   # (community)   programming font
    ttf-jetbrains-mono              # (community)   console font
    unzip                           # (extra)       unzip utility
    usbutils                        # (core)        usb tools
    usb_modeswitch                  # (community)   usb activation
    wireplumber                     # (extra)       pipewire client
    xclip                           # (extra)       clipboard
    xdotool                         # (community)   key/mouse/window fake activity
    zip                             # (extra)       zip utility
)

pkg_py=(
    vdirsyncer                  # (community)   caldav/carddav sync
)

services=(
    ModemManager.service        # modem/mobile network
    NetworkManager.service      # network
    acpid.service               # battery
    bluetooth.service           # bluetooth
)

# install yay
sudo pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

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

sudo chsh -s /bin/fish

# link user files
cp -afl home/.*[^.] $HOME/

# set background
nitrogen --save --set-zoom-fill ~/.local/share/backgrounds/brush-strokes-d.jpg
