{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/300c7b52-4325-4417-9c79-b420bdddb8ee";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7BCA-3C31";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/5091cf6d-827a-429d-95c3-6a9d4f75d898"; }];

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/0cf4f70b-cbf3-45cf-a001-fff9c2c90a82";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-name=HDD" ];
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    pulseaudio.enable = false;

    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    nvidia = {
      powerManagement.enable = true;
      nvidiaSettings = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    xserver.videoDrivers = [ "nvidia" ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
