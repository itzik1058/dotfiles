{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.dev;
in
{
  options.profiles.dev = {
    enable = lib.mkEnableOption "dev profile";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };

    services.udev.packages = with pkgs; [
      platformio-core.udev
      openocd
    ];

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
  };
}
