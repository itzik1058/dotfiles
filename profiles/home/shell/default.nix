{ ... }:
{
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
  };

  programs.fzf.enable = true;
}
