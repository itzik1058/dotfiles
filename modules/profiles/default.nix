{
  imports = [
    ./audio
    ./desktop
    ./dev
    ./gaming
    ./system
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [ ./home.nix ];
  };
}
