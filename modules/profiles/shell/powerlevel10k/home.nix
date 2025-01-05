{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.shell.powerlevel10k;
in
{
  options.profiles.shell.powerlevel10k = {
    enable = lib.mkEnableOption "powerlevel10k profile";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./.;
        file = ".p10k.zsh";
      }
    ];
  };
}
