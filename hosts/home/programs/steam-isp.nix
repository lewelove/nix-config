{ pkgs, username, ... }:

let
  steam-isp = pkgs.writeShellScriptBin "steam-isp" ''
    exec sg novpn -c "steam $*"
  '';
in
{
  environment.systemPackages = [ steam-isp ];

  home-manager.users.${username} = {
    xdg.desktopEntries.steam-isp = {
      name = "Steam (VPN Bypass)";
      genericName = "Games Client";
      exec = "steam-isp %U";
      icon = "steam";
      terminal = false;
      categories = [ "Network" "Game" ];
    };
  };
}
