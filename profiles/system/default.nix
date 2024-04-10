{ ... }:
{
  system.stateVersion = "23.11";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
    };
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
    };
    vim.defaultEditor = true;
  };
}
