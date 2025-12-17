{ inputs, ... }:
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
      imports = [ ];
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
