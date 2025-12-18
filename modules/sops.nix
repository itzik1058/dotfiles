{
  flake = {
    modules.nixos.sops = {
      config = {
        sops = {
          defaultSopsFile = ../secrets/default.yaml;
          age = {
            sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
            keyFile = "/var/lib/sops-nix/keys.txt";
            generateKey = true;
          };
        };
      };
    };
    modules.homeManager.sops =
      { config, ... }:
      {
        config = {
          sops = {
            defaultSopsFile = ../secrets/default.yaml;
            age = {
              sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
              keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
              generateKey = true;
            };
          };
        };
      };
  };
}
