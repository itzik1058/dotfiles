{ nixpkgs }:
{
  x86_64-linux =
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      machine-learning = pkgs.mkShell (import ./machine-learning.nix { inherit pkgs; });
    };
}
