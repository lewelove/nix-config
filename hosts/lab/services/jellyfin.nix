{ config, ... }:

let
  user = config.my.identity.username;
in
{
  services.jellyfin = {
    enable = true;
    openFirewall = false;
  };

  users.users.jellyfin.extraGroups = [ "torrents" ];
  users.users.${user}.extraGroups = [ "jellyfin" ];
}
