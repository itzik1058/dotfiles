set fish_greeting

fish_add_path $HOME/.local/bin

set -gx EDITOR nvim

alias vi="nvim"
alias vim="nvim"
alias mail="kermit -t Mail -e neomutt"
alias calendar="kermit -t Calendar -e ikhal"

if status is-interactive
    # Commands to run in interactive sessions can go here
end