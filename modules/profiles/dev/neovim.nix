{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.dev.neovim;
in
{
  options.profiles.dev.neovim = {
    enable = lib.mkEnableOption "neovim dev profile";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
    };
  };
}
