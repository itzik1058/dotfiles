{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.expireDuplicatesFirst = true;
    history.extended = true;

    historySubstringSearch.enable = true;
  };

  programs.fzf.enable = true;
}
