{ config, ... }:

let
  user = config.my.identity.username;
  wrapper = config.my.chromium.wrapper;
  url = "https://youtube.com";
  name = "YouTube";
  icon = "youtube";
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name icon;
      genericName = "Video Player";
      exec = "${wrapper}/bin/chromium-browser --app=${url}";
      terminal = false;
    };
  };
}
