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

    sharedModules = [
      ./audio/home.nix
      ./autostart/home.nix
      ./desktop/home.nix
      ./dev/home.nix
      ./gaming/home.nix
      ./home-manager/home.nix
      ./shell/home.nix
      ./terminal/home.nix
      ./theme/home.nix
    ];
  };
}
