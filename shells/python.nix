{ pkgs }:
pkgs.mkShell {
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
}
