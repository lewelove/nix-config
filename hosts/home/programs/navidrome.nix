{ config, ... }:

let
  user = config.my.identity.username;
  wrapper = config.my.chromium.wrapper;
  name = "Navidrome";
  url = "navidrome.lewelaboratory.duckdns.org";
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "BitTorrent Client";
      exec = "${wrapper}/bin/chromium-browser --app=https://${url}";
      terminal = false;
      categories = [ "Network" ];
    };
  };
}
