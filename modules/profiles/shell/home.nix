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
  options.profiles.shell = {
    enable = lib.mkEnableOption "shell profile";
    prompt = lib.mkOption {
      description = "shell prompt";
      type =
        with lib.types;
        nullOr (enum [
          "powerlevel10k"
          "starship"
        ]);
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bat ];

    home.shellAliases =
      let
        bat = lib.getExe pkgs.bat;
      in
      {
        cat = "${bat} -Pp";
        man = ''MANROFFOPT="-c" MANPAGER="sh -c 'col -bx | ${bat} -l man -p'" man'';
      };

    programs = {
      fd.enable = true;
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
        icons = true;
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

        defaultKeymap = "viins";

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
          (lib.mkIf (cfg.prompt == "powerlevel10k") {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          })
          (lib.mkIf (cfg.prompt == "powerlevel10k") {
            name = "powerlevel10k-config";
            src = ./powerlevel10k;
            file = ".p10k.zsh";
          })
        ];

        initExtra = ''
          bindkey -a H vi-beginning-of-line
          bindkey -a L vi-end-of-line
          bindkey '^ ' autosuggest-accept
        '';
      };

      starship = lib.mkIf (cfg.prompt == "starship") {
        enable = true;
        settings = {
          add_newline = false;
          format = "$directory$git_branch$fill$all$time$line_break$character";
          fill.symbol = " ";
          status.disabled = false;
          time = {
            disabled = false;
            use_12hr = true;
          };
          palette = "catppuccin_mocha";
          palettes.catppuccin_mocha = {
            # https://github.com/catppuccin/starship
            rosewater = "#f5e0dc";
            flamingo = "#f2cdcd";
            pink = "#f5c2e7";
            mauve = "#cba6f7";
            red = "#f38ba8";
            maroon = "#eba0ac";
            peach = "#fab387";
            yellow = "#f9e2af";
            green = "#a6e3a1";
            teal = "#94e2d5";
            sky = "#89dceb";
            sapphire = "#74c7ec";
            blue = "#89b4fa";
            lavender = "#b4befe";
            text = "#cdd6f4";
            subtext1 = "#bac2de";
            subtext0 = "#a6adc8";
            overlay2 = "#9399b2";
            overlay1 = "#7f849c";
            overlay0 = "#6c7086";
            surface2 = "#585b70";
            surface1 = "#45475a";
            surface0 = "#313244";
            base = "#1e1e2e";
            mantle = "#181825";
            crust = "#11111b";
          };
        };
      };
    };
  };
}
