{ pkgs, username, config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "Transmission";
  url = "192.168.1.100:9095";
in
{
  home-manager.users.${username} = {
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
