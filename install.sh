#!/usr/bin/env bash

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
)

pkg_util=(
    # zsh                       # (extra)       shell
    fish                        # (community)   shell
    alacritty                   # (community)   terminal
    # xss-lock                  # (community)   screen auto lock
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
    steam                       # (multilib)    games
    discord                     # (community)   chat
    qbittorrent                 # (community)   torrent
    neofetch                    # (community)   system information
    onefetch                    # (community)   git repository information
    cmatrix                     # (community)   terminal animation
    cbonsai                     # (aur)         terminal animation
)

services=(
    ModemManager.service        # modem/mobile network
    NetworkManager.service      # network
    acpid.service               # battery
    bluetooth.service           # bluetooth
)

# install yay
sudo pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

yay -Syu ${pkg_util[@]} ${pkg_fonts[@]} ${pkg_desktop[@]} ${pkg_apps[@]}

systemctl enable ${services[@]}
systemctl start ${services[@]}

# # ohmyzsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# sudo chsh -s /bin/zsh
sudo chsh -s /bin/fish

# xwinwrap (for animated background)
git clone https://github.com/ujjwal96/xwinwrap.git && cd xwinwrap && make && sudo make install && make clean && cd .. && rm -rf xwinwrap

# cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
# sed -i 's;/usr/bin/google-chrome-stable;/usr/bin/google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode;g' ~/.local/share/applications/google-chrome.desktop

# move configuration files
# cp -lf .zshrc ~/.zshrc
cp -lf .xinitrc ~/.xinitrc
cp -al .config/* ~/.config/

# move bin
sudo ln -f usr/local/bin/* /usr/local/bin/

# move fonts
# mkdir -p ~/.local/share/fonts && sudo cp -al .local/share/fonts/* ~/.local/share/fonts/
# fc-cache -v

# move backgrounds
sudo mkdir -p /usr/local/share/backgrounds && sudo cp -al usr/local/share/backgrounds/* /usr/local/share/backgrounds/

# set background
nitrogen --set-zoom-fill /usr/local/share/backgrounds/brush-strokes-d.jpg
