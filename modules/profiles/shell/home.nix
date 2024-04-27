{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.shell;
in
{
  options.profiles.shell = {
    enable = mkEnableOption "shell profile";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.expireDuplicatesFirst = true;
      history.extended = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "history-substring-search" ];
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./powerlevel10k;
          file = ".p10k.zsh";
        }
      ];
    };

    programs.fzf.enable = true;
  };
}
