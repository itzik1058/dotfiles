{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.system;
in
{
  options.profiles.system = {
    enable = lib.mkEnableOption "system profile";
  };

  config = lib.mkIf cfg.enable {
    system.stateVersion = "23.11";

    nix = {
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        persistent = true;
      };
      optimise.automatic = true;
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.memtest86.enable = true;
    boot.loader.grub.memtest86.enable = true;

    zramSwap.enable = true;

    networking.firewall = {
      logReversePathDrops = true;

      # rpfilter ignore wireguard traffic
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };

    services.fstrim.enable = true;

    environment.systemPackages = with pkgs; [
      wget
    ];

    programs = {
      zsh.enable = true;
      git = {
        enable = true;
        lfs.enable = true;
      };
      vim.enable = true;
    };

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  };
}
