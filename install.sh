#!/usr/bin/env bash
# shellcheck disable=SC2068,SC2046,SC2086

cd $(dirname $(realpath $0)) || exit

pkg_desktop=(
    i3-wm                       # (community)   window manager
    rofi                        # (community)   menus
    polybar                     # (community)   status bars
    libnotify                   # (extra)       notification events
    dunst                       # (community)   notification daemon
    picom                       # (community)   window compositor
    networkmanager-dmenu-git    # (aur)         network menu
)

pkg_fonts=(
    noto-fonts                  # (extra)       google font family
    noto-fonts-cjk              # (extra)       chinese/japanese/korean
    noto-fonts-emoji            # (extra)       emoji
    noto-fonts-extra            # (extra)       additional variants
    ttf-font-awesome            # (community)   icon library
    ttf-fira-code               # (community)   programming font
    ttf-jetbrains-mono          # (community)   console font
    # ttf-inconsolata             # (community)
    # ttc-iosevka                 # (community)
)

pkg_util=(
    # perl-anyevent-i3            # (community)   required for i3-save-tree
    # perl-json-xs                # (community)   required for i3-save-tree
    # zsh                         # (extra)       shell
    fish                        # (community)   shell
    alacritty                   # (community)   terminal
    # sakura                      # (aur)         terminal with bidi support
    kermit                      # (aur)         terminal with bidi support
    # xss-lock                    # (community)   screen auto lock
    ffmpeg                      # (extra)       media conversion
    bluez bluez-utils           # (extra)       bluetooth
    acpi                        # (community)   battery status
    xdotool                     # (community)   key/mouse/window fake activity
    maim                        # (community)   screen capture
    xclip                       # (extra)       clipboard
    rofi-greenclip              # (aur)         clipboard manager
    gifsicle                    # (community)   gif
    ntfs-3g                     # (extra)       ntfs partition support
    iotop                       # (community)   io information
    vdirsyncer                  # (community)   caldav/carddav sync
    python-aiohttp-oauthlib     # (community)   dependency for vdirsyncer
    urlscan                     # (community)   url scan for neomutt
    python-click-repl           # (community)   tui dependency for todoman
    yt-dlp                      # (community)   youtube downloader (for ytfzf)
    fzf                         # (community)   cli fuzzy finder (for ytfzf)
    # socat                       # (extra)       stream relay (for ytfzf with thumbnails in mpv)
    ueberzug                    # (community)   display image in terminal (for ytfzf)
    # isync                       # (community)   sync mail
)

pkg_apps=(
    network-manager-applet      # (extra)       network manager
    blueman                     # (community)   bluetooth manager
    cmus                        # (community)   audio
    mpv                         # (community)   video
    nitrogen                    # (extra)       image viewer
    code                        # (community)   ide
    code-marketplace            # (aur)         vscode extensions
    code-features               # (aur)         vscode extensions dependencies
    thunar                      # (extra)       file browser
    ranger                      # (community)   file browser cli
    google-chrome               # (aur)         web browser
    bitwarden                   # (community)   password manager
    github-desktop-bin          # (aur)         github desktop
    taskwarrior-tui             # (community)   task list
    todoman                     # (community)   task list
    steam                       # (multilib)    games
    discord                     # (community)   chat
    qbittorrent                 # (community)   torrent
    neofetch                    # (community)   system information
    onefetch                    # (community)   git repository information
    cmatrix                     # (community)   terminal animation
    # cbonsai                     # (aur)         terminal animation
    khal                        # (community)   calendar
    neomutt                     # (community)   email
    lynx                        # (extra)       text web browser for neomutt
    ytfzf                       # (community)   youtube in terminal
    translate-shell             # (community)   translate cli
)

services=(
    ModemManager.service        # modem/mobile network
    NetworkManager.service      # network
    acpid.service               # battery
    bluetooth.service           # bluetooth
)

user_services=(
    vdirsyncer.timer            # vdirsyncer
)

# install yay
sudo pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

yay -Syu ${pkg_util[@]} ${pkg_fonts[@]} ${pkg_desktop[@]} ${pkg_apps[@]}

systemctl enable ${services[@]}
systemctl start ${services[@]}
systemctl --user enable ${user_services[@]}
systemctl --user start ${user_services[@]}

# X11 Keymap
# us/il layouts, toggle layout with alt+shift, map caps lock to ctrl
# use setxkbmap for more options
localectl set-x11-keymap us,il grp:alt_shift_toggle caps:ctrl_modifier

# # ohmyzsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# sudo chsh -s /bin/zsh
sudo chsh -s /bin/fish

# xwinwrap (for animated background)
git clone https://github.com/ujjwal96/xwinwrap.git && cd xwinwrap && make && sudo make install && make clean && cd .. && rm -rf xwinwrap

# cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
# sed -i 's;/usr/bin/google-chrome-stable;/usr/bin/google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode;g' ~/.local/share/applications/google-chrome.desktop

# link user files
cp -al home/.* $HOME/

# set background
nitrogen --set-zoom-fill ~/.local/share/backgrounds/brush-strokes-d.jpg
