{ lib, ... }:

{
  imports = [
    ./video.nix
    ./mount.nix
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
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

  swapDevices = [ { device = "/dev/disk/by-uuid/5091cf6d-827a-429d-95c3-6a9d4f75d898"; } ];

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  specialisation = {
    vfio.configuration = {
      imports = [ ./vfio ];
      system.nixos.tags = [ "vfio" ];
      services.sunshine.enable = false;
    };
  };
}
