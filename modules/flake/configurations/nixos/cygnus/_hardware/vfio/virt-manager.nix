{ pkgs, ... }:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd.enable = true;
  };

  users.users.koi.extraGroups = [ "libvirtd" ];

  programs.virt-manager.enable = true;

  environment.systemPackages = [ pkgs.virtiofsd ];

  home-manager.users.koi.dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
}
