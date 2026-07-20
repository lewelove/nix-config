{ config, pkgs, username, ... }:

{
  services.syncthing = {
    enable = true;
    user = username;
    group = "users";
    configDir = "/home/${username}/.config/syncthing";
    
    guiAddress = "0.0.0.0:8384";

    overrideDevices = false;
    overrideFolders = false;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
