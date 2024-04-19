{ lib, config, ... }:
with lib;
path: homeModule:
let
  cfg = (getAttrFromPath path config);
in
{
  options = setAttrByPath path {
    users = mkOption {
      type =
        with types;
        attrsOf (submodule {
          options = getAttrFromPath path homeModule.options;
        });
      default = { };
    };
  };
  config.home-manager.users = mapAttrs (
    _: home: recursiveUpdate { imports = [ homeModule ]; } (getAttrFromPath path home)
  ) cfg.users;
}
