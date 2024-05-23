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
    python = pkgs.mkShell {
      packages = with pkgs; [
        ffmpeg
        (python3.withPackages (
          python-pkgs: with python-pkgs; [
            pip
            numpy
            pandas
            scikit-learn
            matplotlib
            plotly
            jupyterlab
          ]
        ))
      ];
    };
  }
)
