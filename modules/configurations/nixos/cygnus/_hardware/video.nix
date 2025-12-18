{ pkgs, ... }:
{
  boot.kernelParams = [ "module_blacklist=i915" ];

  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      prime = {
        sync.enable = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    nvidia-container-toolkit.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
