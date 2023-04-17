set fish_greeting

fish_add_path $HOME/.local/bin

set -Ux EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
end
