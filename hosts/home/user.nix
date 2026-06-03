{ config, pkgs, inputs, username, ... }:

{
  services.getty.autologinUser = "${username}";

  users.groups.novpn = {};

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "novpn" ];
    shell = pkgs.fish; 
    autoSubUidGidRange = true;
  };

  security.sudo.extraRules = [
    {
      users = [ "${username}" ];
      commands = [
        { command = "/run/current-system/sw/bin/awgg"; options = [ "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/awgd"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];
}
