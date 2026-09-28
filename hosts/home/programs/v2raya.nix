{ config, ... }:

let
  user = config.my.identity.username;
  wrapper = config.my.chromium.wrapper;
  name = "v2RayA";
  url = "192.168.1.100:2017";
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "BitTorrent Client";
      exec = "${wrapper}/bin/chromium-browser --app=http://${url}";
      icon = "transmission";
      terminal = false;
      categories = [ "Network" ];
    };
  };
}
