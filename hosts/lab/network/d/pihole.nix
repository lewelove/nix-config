{ config, pkgs, lib, ... }:

{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;

    settings = {
      dns = {
        upstreams = [
          "1.1.1.1"
          "9.9.9.9"
        ];
      };
      webserver = {
        port = "8085"; # Local port for FTL's embedded HTTP server
      };
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        description = "Steven Black Unified Hosts";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ 8085 ];
  };

  services.doh-server = {
    enable = true;
    settings = {
      listen = [ "127.0.0.1:8053" ];
      path = "/dns-query";
      upstream = [ "udp:127.0.0.1:53" ];
      timeout = 10;
      tries = 3;
      verbose = false;
      log_guessed_client_ip = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
