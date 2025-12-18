{
  flake = {
    modules.nixos.dev =
      { pkgs, ... }:
      {
        config = {
          virtualisation.docker = {
            enable = true;
            # rootless = {
            #   enable = true;
            #   setSocketVariable = true;
            # };
          };

          services.udev.packages = with pkgs; [
            platformio-core.udev
            openocd
          ];

          programs.nix-ld = {
            enable = true;
            libraries = with pkgs; [
              zlib
              zstd
              stdenv.cc.cc
              curl
              openssl
              attr
              libssh
              bzip2
              libxml2
              acl
              libsodium
              util-linux
              xz
              systemd
              libGL
              glib
            ];
          };
        };
      };
    modules.homeManager.dev =
      { pkgs, ... }:
      {
        config = {
          home.packages = with pkgs; [
            sshfs
            gh
            lazygit
            nixfmt-rfc-style
            docker-compose
            lazydocker
            sops
            uv
            neovide
            aseprite
            godot_4
          ];

          programs = {
            direnv = {
              enable = true;
              nix-direnv.enable = true;
            };
            nixvim = {
              enable = true;
              defaultEditor = true;
              vimdiffAlias = true;
            };
            vscode = {
              enable = true;
              mutableExtensionsDir = true;
              profiles.default = {
                enableUpdateCheck = true;
                enableExtensionUpdateCheck = true;
                extensions = with pkgs.vscode-extensions; [ mkhl.direnv ];
                keybindings = [ ];
                userSettings = { };
              };
            };
          };
        };
      };
    modules.darwin.dev = {
      config = {
        homebrew.casks = [
          "iterm2"
          "docker-desktop"
        ];
      };
    };
  };
}
