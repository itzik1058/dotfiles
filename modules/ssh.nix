{
  flake = {
    modules.nixos.ssh = {
      config = {
        services.openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
            KbdInteractiveAuthentication = false;
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };
      };
    };
  };
}
