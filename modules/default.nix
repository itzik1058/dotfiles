{
  imports = [
    ./audio
    ./dev
    ./gaming
    ./gnome
    ./system
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      ./audio/home.nix
      ./autostart/home.nix
      ./dev/home.nix
      ./gaming/home.nix
      ./gnome/home.nix
      ./home-manager/home.nix
      ./shell/home.nix
      ./theme/home.nix
    ];
  };
}
