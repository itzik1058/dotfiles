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
      packages = with pkgs; [
        nixfmt-rfc-style
        nixd
      ];
    };
    python = import ./python.nix { inherit pkgs; };
  }
)
