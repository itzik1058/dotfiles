{
  flake = {
    modules.nixos.installer =
      { config, modulesPath, ... }:
      {
        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
        config = {
          boot.supportedFilesystems.zfs = false; # broken
          isoImage = {
            compressImage = true;
            edition = config.networking.hostName;
            configurationName = config.networking.hostName;
          };
        };
      };
  };
}
