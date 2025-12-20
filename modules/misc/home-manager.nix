{ config, inputs, ... }:
{
  flake = {
    modules.nixos.home-manager = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
    modules.homeManager.home-manager = {
      imports = [ config.flake.modules.homeManager.imports ];
      config = {
        home.stateVersion = "23.11";
        programs.home-manager.enable = true;
      };
    };
    modules.darwin.home-manager = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
