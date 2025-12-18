{
  flake = {
    modules.nixos.wireguard = {
      config = {
        networking.firewall = {
          logReversePathDrops = true;

          # rpfilter ignore wireguard traffic
          extraCommands = ''
            ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
            ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
          '';
          extraStopCommands = ''
            ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
            ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
          '';
        };
      };
    };
  };
}
