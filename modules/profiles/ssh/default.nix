{ lib, config, ... }:
let
  cfg = config.profiles.ssh;
in
{
  options.profiles.ssh = {
    enable = lib.mkEnableOption "ssh profile";
    ports = lib.mkOption {
      type = with lib.types; listOf port;
      default = [ 22 ];
      description = "OpenSSH ports";
    };
  };

  config = lib.mkIf cfg.enable {
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
