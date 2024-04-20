{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.dev;
in
{
  options.profiles.dev = {
    enable = mkEnableOption "dev profile";
  };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
        libGL
        glib
      ];
    };

    services.envfs.enable = true;
    services.udev.packages = with pkgs; [
      platformio-core.udev
      openocd
    ];
  };
}
