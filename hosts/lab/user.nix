{ config, pkgs, inputs, username, ... }:

{
  
  # services.getty.autologinUser = "${username}";

  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish; 
    autoSubUidGidRange = true;
    initialPassword = "lab";
  };

  security.sudo.wheelNeedsPassword = true;

}
