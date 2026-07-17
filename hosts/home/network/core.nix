{ config, pkgs, username, hostname, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.checkReversePath = "loose";
    firewall.allowedTCPPorts = [ 80 8080 6600 666 2234 2235 ];
    firewall.allowedUDPPorts = [ 9 2234 2235 ];

    interfaces.enp3s0.wakeOnLan.enable = true;

    firewall.extraCommands = ''
      iptables -t mangle -A OUTPUT -m owner --gid-owner novpn -j MARK --set-mark 0xca6c
      iptables -t nat -A POSTROUTING -o enp3s0 -m mark --mark 0xca6c -j MASQUERADE
    '';
  };

  systemd.services.wol-enp3s0 = {
    description = "Force Wake-on-LAN for enp3s0";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp3s0 wol g";
      RemainAfterExit = true;
    };
  };

  environment.systemPackages = [ pkgs.ethtool ];
}
