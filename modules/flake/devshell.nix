{
  perSystem =
    {
      lib,
      pkgs,
      self',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShell {
          inherit (self'.checks.pre-commit-check) shellHook;
          buildInputs = self'.checks.pre-commit-check.enabledPackages;

          packages = [
            (pkgs.writeShellScriptBin "rebuild" (
              if pkgs.stdenv.isDarwin then
                ''
                  darwin-rebuild --flake . "$@"
                ''
              else
                ''
                  nixos-rebuild --flake . --log-format internal-json -v "$@" \
                  |& ${lib.getExe pkgs.nix-output-monitor} --json \
                  && nix store diff-closures /run/*-system
                ''
            ))
          ];
        };
      };
    };
}
