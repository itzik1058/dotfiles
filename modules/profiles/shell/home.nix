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
    ./tmux/home.nix
    ./zellij/home.nix
    ./zsh/home.nix
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
    };

    profiles.shell = {
      tmux.enable = true;
      zsh.enable = true;
    };
  };
}
