{ pkgs, username, config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "Navidrome";
  url = "navidrome.lewelaboratory.duckdns.org";
in
{
  home-manager.users.${username} = {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "BitTorrent Client";
      exec = "${wrapper}/bin/chromium-browser --app=https://${url}";
      terminal = false;
      categories = [ "Network" ];
    };
  };
}

