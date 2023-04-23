set fish_greeting

fish_add_path $HOME/.local/bin

set -Ux EDITOR nvim

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx
  end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
end
