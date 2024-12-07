{ nixpkgs }:
let
  supportedSystems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];
in
nixpkgs.lib.genAttrs supportedSystems (
  system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    default = pkgs.mkShell {
      buildInputs = with pkgs; [
        nixfmt-rfc-style
        nixd
        (writeShellScriptBin "rebuild" ''
          nixos-rebuild --flake . "$@" && nix store diff-closures /run/*-system
        '')
      ];
    };
    python = import ./python.nix { inherit pkgs; };
  }
)
