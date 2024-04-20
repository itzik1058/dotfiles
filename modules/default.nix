{ self, ... }:
{
  imports = [
    self.inputs.home-manager.nixosModules.home-manager
    ./dev
    ./gaming
    ./gnome
    ./home-manager
    ./system
  ];
}
