{ config, pkgs, ... }:

{
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 3000 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
