{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.shell.zsh;
in
{
  options.profiles.shell.zsh = {
    enable = lib.mkEnableOption "zsh profile";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.expireDuplicatesFirst = true;
      history.extended = true;

      historySubstringSearch = {
        enable = true;
        searchDownKey = [
          "^[[B"
          "^[OB"
        ];
        searchUpKey = [
          "^[[A"
          "^[OA"
        ];
      };

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      initContent = ''
        bindkey -a H vi-beginning-of-line
        bindkey -a L vi-end-of-line
        bindkey '^ ' autosuggest-accept
      '';
    };
  };
}
