{ config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  url = "https://jellyfin.lewelaboratory.duckdns.org/";
  name = "Jellyfin";
  icon = "jellyfin";
  user = config.my.identity.username;
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name icon;
      genericName = "Media Server";
      exec = "${wrapper}/bin/chromium-browser --app=${url}";
      terminal = false;
    };
  };
}
