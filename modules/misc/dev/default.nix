top: {
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
      { pkgs, lib, ... }:
      {
        imports = [ top.config.flake.modules.homeManager.neovim ];

        config = {
          home.packages =
            with pkgs;
            [
              bun
              cargo
              commitizen
              docker-compose
              gcc
              gh
              lazydocker
              lazygit
              neovide
              nixfmt
              opencode
              rustc
              rustfmt
              sops
              sshfs
            ]
            ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
              godot_4
            ];

          programs = {
            direnv = {
              enable = true;
              nix-direnv.enable = true;
            };
            uv.enable = true;
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

          xdg.configFile."opencode/AGENTS.md".source = ./AGENTS.md;
        };
      };
    modules.darwin.dev = {
    };
  };
}
