{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.shell.tmux;
in
{
  options.profiles.shell.tmux = {
    enable = lib.mkEnableOption "tmux profile";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "A-space";
      keyMode = "vi";
      baseIndex = 1;
      clock24 = true;
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        vim-tmux-navigator
        {
          plugin = resurrect;
          extraConfig = ''
            resurrect_dir="$HOME/.tmux/resurrect"
            set -g @resurrect-dir $resurrect_dir
            set -g @resurrect-hook-post-save-all "sed -i 's/--cmd lua.*--cmd set packpath/--cmd \"lua/g; s/--cmd set rtp.*\$/\"/' $resurrect_dir/last"
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-processes '"~nvim"'
          '';
        }
      ];
    };
  };
}
