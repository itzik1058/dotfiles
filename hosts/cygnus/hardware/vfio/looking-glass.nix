{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.looking-glass-client ];

  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 koi kvm -" ];
}
