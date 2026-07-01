{ config, pkgs, ... }:

{
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 3000 ];
    extraCommands = ''
      VPN_IPS=(
        "185.200.118.4"
        "185.200.118.5"
      )
      for ip in "''${VPN_IPS[@]}"; do
        iptables -A INPUT -p udp -s "$ip" --dport 53 -j ACCEPT
        iptables -A INPUT -p tcp -s "$ip" --dport 53 -j ACCEPT
      done
    '';
  };
}
