{ config, ... }:

let
  user = config.my.identity.username;
  wrapper = config.my.chromium.wrapper;
  name = "Soulseek";
  domain = "192.168.1.100:5030";
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "Soulseek Client";
      exec = "${wrapper}/bin/chromium-browser --app=http://${domain}";
      terminal = false;
    };
  };
}
