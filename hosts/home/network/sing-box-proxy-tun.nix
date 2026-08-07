{ pkgs, ... }:

{
  networking.firewall.trustedInterfaces = [ "tun0" ];

  services.sing-box = {
    enable = true;
    settings = {
      log = {
        level = "info";
      };
      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          interface_name = "tun0";
          address = [ "172.19.0.1/30" ];
          auto_route = true;
          strict_route = true;
          stack = "mixed";
        }
      ];
      outbounds = [
        {
          type = "socks";
          tag = "lab-proxy";
          server = "192.168.1.100";
          server_port = 20170;
        }
        {
          type = "direct";
          tag = "direct";
        }
      ];
      route = {
        auto_detect_interface = true;
        final = "lab-proxy";
        rules = [
          {
            action = "sniff";
          }
          {
            ip_cidr = [
              "192.168.1.0/24"
              "127.0.0.0/8"
              "10.0.0.0/8"
            ];
            action = "route";
            outbound = "direct";
          }
        ];
      };
    };
  };
}
