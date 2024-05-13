{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.ssh;
in
{
  options.profiles.ssh = {
    enable = mkEnableOption "ssh profile";
    ports = mkOption {
      type = with types; listOf port;
      default = [ 22 ];
      description = "OpenSSH ports";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = cfg.ports;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
