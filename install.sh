#!/usr/bin/env bash

cd $(dirname $(realpath $0))

pkg_desktop=(
    i3-gaps                     # window manager
    i3lock                      # lock screen
    rofi                        # menus
    polybar                     # status bars
    libnotify                   # notification events
    dunst                       # notification daemon
    picom                       # window compositor
    networkmanager-dmenu-git    # network menu
)

pkg_fonts=(
    ttf-fira-code
    ttf-font-awesome
    # nerd-fonts-complete
)

pkg_util=(
    zsh                         # shell
    alacritty                   # terminal
    xss-lock                    # screen auto lock
    ffmpeg                      # media conversion
    bluez bluez-utils           # bluetooth
    acpi                        # battery status
    xdotool                     # key/mouse/window fake activity
    maim                        # screen capture
    xclip                       # clipboard
    rofi-greenclip              # clipboard manager
    gifsicle                    # gif
    ntfs-3g                     # ntfs usb
    iotop                       # io information
)

pkg_apps=(
    cmus                        # audio
    mpv                         # video
    nitrogen                    # image viewer
    code                        # ide
    thunar ranger               # file browser
    google-chrome               # web browser
    bitwarden                   # password manager
    github-desktop-bin          # github desktop
    task-warrior-tui            # task list
    steam                       # games
    discord                     # chat
    qbittorrent                 # torrent
    neofetch                    # system information
    onefetch                    # git repository information
    cmatrix cbonsai             # cmd animation
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

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo chsh -s /bin/zsh
# xwinwrap
git clone https://github.com/ujjwal96/xwinwrap.git && cd xwinwrap && make && sudo make install && make clean && cd .. && rm -rf xwinwrap

# cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
# sed -i 's;/usr/bin/google-chrome-stable;/usr/bin/google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode;g' ~/.local/share/applications/google-chrome.desktop

# move configuration files
cp -l .zshrc ~/.zshrc
cp -al .config/* ~/.config/

# move bin
sudo ln -f usr/local/bin/* /usr/local/bin/

# move fonts
mkdir -p ~/.local/share/fonts && sudo cp -al .local/share/fonts/* ~/.local/share/fonts/
fc-cache -v

# move backgrounds
sudo mkdir -p /usr/local/share/backgrounds && sudo cp -al usr/local/share/backgrounds/* /usr/local/share/backgrounds/

# set background
nitrogen --set-zoom-fill /usr/local/share/backgrounds/brush-strokes-d.jpg
