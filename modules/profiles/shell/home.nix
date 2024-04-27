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

      plugins = [
        {
          name = "history-substring-search";
          src = pkgs.zsh-history-substring-search;
          file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
        }
      ];
    };

    programs.fzf.enable = true;
  };
}
