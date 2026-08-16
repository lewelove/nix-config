{ pkgs, lib, username, config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "Soulseek";
  # domain = "slskd.lewelaboratory.duckdns.org";
  domain = "192.168.1.100:5030";
in
{
  home-manager.users.${username} = {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "Soulseek Client";
      exec = "${wrapper}/bin/chromium-browser --app=http://${domain}";
      terminal = false;
    };
  };
}

