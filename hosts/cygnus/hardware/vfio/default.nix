let
  pciIds = [
    "10de:1b80" # 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP104 [GeForce GTX 1080] [10de:1b80] (rev a1)
    "10de:10f0" # 01:00.1 Audio device [0403]: NVIDIA Corporation GP104 High Definition Audio Controller [10de:10f0] (rev a1)
  ];
in
{ lib, pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      "intel_iommu=on"
      ("vfio-pci.ids=" + lib.concatStringsSep "," pciIds)
    ];
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd.enable = true;
  };

  users.users.koi.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    (import ./ls-iommu-groups.nix { inherit pkgs; })
    spice
    spice-gtk
    spice-protocol
    virt-viewer
    virtio-win
    win-spice
  ];

  programs.virt-manager.enable = true;

  home-manager.users.koi.dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
}
