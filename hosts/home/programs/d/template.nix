{ pkgs, lib, config, ... }:

let
  user = config.my.identity.username;
  wrapper = config.my.chromium.wrapper;
  url = "https://TEMPLATE";
  name = "TEMPLATE";
  icon = "TEMPLATE";
in
{
  home-manager.users.${user} = {
    xdg.desktopEntries.${name} = {
      inherit name icon;
      genericName = "${name}";
      exec = "${wrapper}/bin/chromium-browser --app=${url}";
      terminal = false;
    };
  };
}
