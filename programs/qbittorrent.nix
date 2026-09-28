{ config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "qBittorrent";
  icon = "qbittorrent";
  domain = "qbittorrent.lab";
  ip = "192.168.1.100";
  port = 8081;
  user = config.my.identity.username;
in
{
  networking.hosts."${ip}" = [ domain ];

  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name icon;
      genericName = "Torrent Client";
      exec = "${wrapper}/bin/chromium-browser --app=http://${domain}:${toString port}";
      terminal = false;
    };
  };
}
