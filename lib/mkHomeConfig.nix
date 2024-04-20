{ lib, config, ... }:
with lib;
path: homeModule:
let
  cfg = (getAttrFromPath path config);
in
{
  options = setAttrByPath path {
    users = mkOption {
      type = types.attrs;
      default = { };
    };
  };
  config = mkIf cfg.enable {
    home-manager.users = mapAttrs (
      _: home: recursiveUpdate { imports = [ homeModule ]; } (setAttrByPath path home)
    ) cfg.users;
  };
}
