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
            bash = {
              enable = true;
              historyFile = "${config.xdg.stateHome}/.bash_history";
            };
            bat.enable = true;
            eza = {
              enable = true;
              git = true;
              icons = "auto";
            };
            fd.enable = true;
            fzf =
              let
                fd = lib.getExe config.programs.fd.package;
              in
              {
                enable = true;
                defaultCommand = fd;
                fileWidget.command = "${fd} --type f";
                changeDirWidget.command = "${fd} --type d";
              };
            jq.enable = true;
            ripgrep.enable = true;
            zoxide.enable = true;
          };

          catppuccin = {
            bat.enable = true;
            fzf.enable = true;
          };
        };
      };
  };
}
