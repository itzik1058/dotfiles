{ pkgs, self, ... }: {
  imports = [ self.inputs.nixos-wsl.nixosModules.wsl ./home.nix ];

  system.stateVersion = "23.11";

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
    };
    optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  wsl = {
    enable = true;
    defaultUser = "nixos";
  };

  networking = { hostName = "wsl"; };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ vim wget git ];
  };
}
