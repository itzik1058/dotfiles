{
  description = "";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self; };
        modules = [ ./hosts/wsl ];
      };
      cygnus = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self; };
        modules = [ ./hosts/cygnus ];
      };
    };
  };
}
