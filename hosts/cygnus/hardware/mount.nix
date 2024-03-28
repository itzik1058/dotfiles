{ ... }: {
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/0cf4f70b-cbf3-45cf-a001-fff9c2c90a82";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-name=HDD" ];
  };

  fileSystems."/mnt/nvme" = {
    device = "/dev/disk/by-uuid/576bcc42-2fb5-4dfe-8efb-16c75363c7c8";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-name=NVME" ];
  };

  # fileSystems."/mnt/nvme" = {
  #   device = "/dev/disk/by-uuid/3F5BEF1862766D0D";
  #   fsType = "ntfs";
  #   options = [
  #     "noauto"
  #     "rw"
  #     "uid=1000"
  #     "x-gvfs-show"
  #     "x-gvfs-name=NVME (NTFS)"
  #     "x-udisks-auth"
  #   ];
  # };
}
