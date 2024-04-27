{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.dev.python;
in
{
  options.profiles.dev.python = {
    enable = mkEnableOption "python dev profile";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.python3.withPackages (
        python-pkgs:
        with python-pkgs;
        [
          fastapi
          openai
          matplotlib
          numpy
          pandas
          python-dotenv
          uvicorn
        ]
        ++ uvicorn.optional-dependencies.standard
      ))
    ];
  };
}
