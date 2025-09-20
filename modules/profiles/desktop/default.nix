{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  imports = [
    ./gnome
    ./hyprland
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
      extraLocales = lib.mkDefault [
        "he_IL.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
          ];
          settings = {
            globalOptions = {
              "Hotkey/TriggerKeys" = {
                "0" = "Super+space";
              };
            };
            inputMethod = {
              "Groups/0" = {
                Name = "Default";
                "Default Layout" = "us";
                DefaultIM = "keyboard-us";
              };
              "Groups/0/Items/0" = {
                Name = "keyboard-us";
                IMEngine = "";
              };
              "Groups/0/Items/1" = {
                Name = "keyboard-il";
                IMEngine = "";
              };
              "Groups/0/Items/2" = {
                Name = "mozc";
                IMEngine = "";
              };
              GroupOrder = {
                "0" = "Default";
              };
            };
          };
        };
      };
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];

    services.earlyoom.enable = true;

    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
      adb.enable = true;
    };

    profiles.desktop.gnome.enable = true;
  };
}
