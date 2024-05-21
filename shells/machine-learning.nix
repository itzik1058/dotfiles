{ pkgs }:
{
  buildInputs = with pkgs; [
    ffmpeg
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip
        numpy
        pandas
        scikit-learn
        torch
        torchaudio
        matplotlib
        jupyterlab
      ]
    ))
  ];
}
