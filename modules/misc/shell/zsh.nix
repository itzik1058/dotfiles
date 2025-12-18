{
  flake = {
    modules.homeManager.zsh =
      { pkgs, ... }:
      {
        config = {
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

            sessionVariables = {
              ZVM_INIT_MODE = "sourcing";
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
      };
  };
}
