{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.shell;
in
{
  imports = [
    ./powerlevel10k/home.nix
    ./starship/home.nix
    ./zellij/home.nix
  ];

  options.profiles.shell = {
    enable = lib.mkEnableOption "shell profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bat ];

    home.shellAliases =
      let
        bat = lib.getExe pkgs.bat;
        procs = lib.getExe pkgs.procs;
      in
      {
        cat = "${bat} -Pp";
        man = ''MANROFFOPT="-c" MANPAGER="sh -c 'col -bx | ${bat} -l man -p'" man'';
        ps = procs;
      };

    programs = {
      fd.enable = true;
      ripgrep.enable = true;
      fzf =
        let
          fd = lib.getExe pkgs.fd;
        in
        {
          enable = true;
          defaultCommand = fd;
          fileWidgetCommand = "${fd} --type f";
          changeDirWidgetCommand = "${fd} --type d";
        };
      eza = {
        enable = true;
        git = true;
        icons = "auto";
      };

      bash = {
        enable = true;
        historyFile = "${config.xdg.stateHome}/.bash_history";
      };

      zsh = {
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

        initExtra = ''
          bindkey -a H vi-beginning-of-line
          bindkey -a L vi-end-of-line
          bindkey '^ ' autosuggest-accept
        '';
      };
    };
  };
}
