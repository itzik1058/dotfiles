#!/usr/bin/env bash
# shellcheck disable=SC2068,SC2046,SC2086

cd $(dirname $(realpath $0)) || exit

pkg=(
    acpid                           # (extra)       acpi event daemon
    blueman                         # (extra)       bluetooth manager
    bluez                           # (extra)       bluetooth
    bluez-utils                     # (extra)       bluetooth
    cdw                             # (aur)         optical disk drive cli
    cliphist                        # (extra)       clipboard manager
    code                            # (extra)       ide
    code-features                   # (aur)         vscode extensions dependencies
    code-marketplace                # (aur)         vscode extensions
    cups                            # (extra)       open printing daemon package
    discord                         # (extra)       chat
    dunst                           # (extra)       notification daemon
    fd                              # (extra)       alternative to find
    ffmpeg                          # (extra)       media conversion
    firefox                         # (extra)       web browser
    fzf                             # (extra)       fuzzy finder
    fzf-tab-git                     # (aur)         fzf search suggestions for zsh
    highlight                       # (extra)       code highlighting (for ranger)
    hyprland                        # (extra)       wayland compositor
    kitty                           # (extra)       terminal
    libnotify                       # (extra)       notification events
    mobile-broadband-provider-info  # (extra)       mobile broadband APN config presets
    modemmanager                    # (extra)       mobile broadband modem management
    mpv                             # (extra)       media player
    neofetch                        # (extra)       system information
    neovim                          # (extra)       text editor
    nerd-fonts                      # (extra)       nerd fonts
    networkmanager                  # (extra)       network connection manager
    network-manager-applet          # (extra)       network manager tray applet
    noto-fonts                      # (extra)       google font family
    noto-fonts-cjk                  # (extra)       chinese/japanese/korean
    noto-fonts-emoji                # (extra)       emoji
    noto-fonts-extra                # (extra)       additional variants
    npm                             # (extra)       package manager for javascript
    ntfs-3g                         # (extra)       ntfs partition support
    otf-font-awesome                # (extra)       font awesome
    pipewire                        # (extra)       audio/video processor
    pipewire-alsa                   # (extra)       alsa replacement for pipewire
    pipewire-jack                   # (extra)       jack support for pipewire
    pipewire-pulse                  # (extra)       pulseaudio replacement for pipewire
    polkit-kde-agent                # (extra)       authentication agent
    powerline-fonts                 # (extra)       fonts for zsh-theme-powerlevel10k
    pyright                         # (extra)       python LSP (for nvim)
    python-pip                      # (extra)       python package manager
    python-pipx                     # (extra)       python isolated packages
    ranger                          # (extra)       file browser cli
    ripgrep                         # (extra)       recursive regex grep
    ruff                            # (extra)       python linter
    steam                           # (multilib)    games
    swww                            # (extra)       wayland wallpaper
    ttf-font-awesome                # (extra)       font awesome
    ttf-fira-code                   # (extra)       fira font
    ttf-jetbrains-mono              # (extra)       jetbrains font
    udiskie                         # (extra)       disk automount
    usbutils                        # (core)        usb tools
    wireplumber                     # (extra)       pipewire client
    waybar                          # (extra)       status bar for wayland
    wayland                         # (extra)       display server protocol
    wofi                            # (extra)       app launcher
    xdg-desktop-portal-gtk          # (extra)       xdg portal file picker
    xdg-desktop-portal-hyprland     # (extra)       xdg portal extra features
    zathura                         # (extra)       document viewer
    zathura-pdf-mupdf               # (extra)       zathura plugin for pdf
    zip                             # (extra)       zip utility
    zsh                             # (extra)       shell
    zsh-autosuggestions             # (extra)       suggestions for zsh
    zsh-syntax-highlighting         # (extra)       syntax highlighting for zsh
    zsh-theme-powerlevel10k         # (extra)       zsh theme
)

pkg_py=(
    poetry                          # (pypi)        python dependency manager
)

services=(
    ModemManager.service                # modem/mobile network
    NetworkManager.service              # network
    acpid.service                       # battery
    bluetooth.service                   # bluetooth
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

chsh -s /bin/zsh

# link user files
cp -aflv home/.*[^.] $HOME/
