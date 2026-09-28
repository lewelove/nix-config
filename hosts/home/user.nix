{ config, pkgs, ... }:

let
  user = config.my.identity.username;
in
{
  services.getty.autologinUser = user;

  users.groups.novpn = {};

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "novpn" "i2c" ];
    shell = pkgs.fish; 
    autoSubUidGidRange = true;
  };

  security.sudo.extraRules = [
    {
      users = [ user ];
      commands = [
        { command = "/run/current-system/sw/bin/awgg"; options = [ "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/awgd"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];
}
