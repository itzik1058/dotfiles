{ pkgs, self, ... }: {
  imports =
    [ self.inputs.nixos-wsl.nixosModules.wsl ./home.nix ../../profiles/system ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  wsl = {
    enable = true;
    defaultUser = "nixos";
  };

  networking = { hostName = "wsl"; };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ wget ];
  };
}
