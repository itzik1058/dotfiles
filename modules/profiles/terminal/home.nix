{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.terminal;
in
{
  imports = [
    ./alacritty/home.nix
    ./foot/home.nix
    ./ghostty/home.nix
  ];

  options.profiles.terminal = {
    defaultTerminal = lib.mkOption {
      type =
        with lib.types;
        nullOr (enum [
          "alacritty"
          "foot"
          "ghostty"
        ]);
      description = "terminal";
      default = null;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.defaultTerminal == "alacritty") { profiles.terminal.alacritty.enable = true; })
    (lib.mkIf (cfg.defaultTerminal == "foot") { profiles.terminal.foot.enable = true; })
    (lib.mkIf (cfg.defaultTerminal == "ghostty") { profiles.terminal.ghostty.enable = true; })
  ];
}
