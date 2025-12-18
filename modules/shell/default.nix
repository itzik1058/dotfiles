{
  flake = {
    modules.homeManager.shell =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          home.shellAliases =
            let
              bat = lib.getExe config.programs.bat.package;
              procs = lib.getExe pkgs.procs;
            in
            {
              cat = "${bat} -Pp";
              man = ''MANROFFOPT="-c" MANPAGER="sh -c 'col -bx | ${bat} -l man -p'" man'';
              ps = procs;
            };

          programs = {
            zoxide.enable = true;
            bat.enable = true;
            fd.enable = true;
            ripgrep.enable = true;
            fzf =
              let
                fd = lib.getExe config.programs.fd.package;
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

          catppuccin = {
            bat.enable = true;
            fzf.enable = true;
          };
        };
      };
  };
}
