{ config, ... }:

let
  user = config.my.identity.username;
in
{
  services.syncthing = {
    enable = true;
    user = user;
    group = "users";
    configDir = "/home/${user}/.config/syncthing";
    
    guiAddress = "0.0.0.0:8384";

    overrideDevices = false;
    overrideFolders = false;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
