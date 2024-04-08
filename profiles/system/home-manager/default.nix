{ self, ... }:
{
  imports = [ self.inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
