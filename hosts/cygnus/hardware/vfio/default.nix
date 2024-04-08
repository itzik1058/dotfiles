let
  pciIds = [
    "10de:1b80" # 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP104 [GeForce GTX 1080] [10de:1b80] (rev a1)
    "10de:10f0" # 01:00.1 Audio device [0403]: NVIDIA Corporation GP104 High Definition Audio Controller [10de:10f0] (rev a1)
  ];
in
{ lib, pkgs, ... }:
{
  imports = [ ./virt-manager.nix ];

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

  environment.systemPackages = [ (import ./ls-iommu-groups.nix { inherit pkgs; }) ];
}
