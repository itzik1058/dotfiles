{ ... }: {
  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/0cf4f70b-cbf3-45cf-a001-fff9c2c90a82";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" "x-gvfs-name=HDD" ];
  };
}
