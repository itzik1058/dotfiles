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
      prefix = "C-a";
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
            set -g @resurrect-hook-post-save-all "sed -i -E 's|:/nix/store/[^ ]+/bin/nvim.*|:nvim|g' $resurrect_dir/last"
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-processes '"~nvim"'
          '';
        }
      ];
    };
  };
}
