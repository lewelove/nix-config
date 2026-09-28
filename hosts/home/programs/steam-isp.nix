{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  steam-isp = pkgs.writeShellScriptBin "steam-isp" ''
    exec sg novpn -c "steam $*"
  '';
in
{
  environment.systemPackages = [ steam-isp ];

  home-manager.users.${user} = {
    xdg.desktopEntries.steam-isp = {
      name = "Steam (ISP Connection)";
      genericName = "Games Client";
      exec = "steam-isp %U";
      icon = "steam";
      terminal = false;
      categories = [ "Network" "Game" ];
    };
  };
}
