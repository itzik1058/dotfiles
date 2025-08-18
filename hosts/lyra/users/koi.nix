{
  home.homeDirectory = "/Users/koi";

  profiles = {
    dev.enable = true;
    home-manager.enable = true;
    shell = {
      enable = true;
      starship.enable = true;
    };
    system.enable = true;
  };
}
