{ config, pkgs, ... }:

let
  user = config.my.identity.username;
in
{
  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish; 
    autoSubUidGidRange = true;
    initialPassword = "lab";
  };

  security.sudo.wheelNeedsPassword = true;
}
