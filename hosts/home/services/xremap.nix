{ config, pkgs, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
in
{
  home-manager.users.${user} = { config, pkgs, ... }: {
    home.file.".config/xremap/".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/xremap/";

    systemd.user.services.xremap = {
      Unit = {
        Description = "xremap keyboard remapper";
        After = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.xremap}/bin/xremap --watch=device ${config.home.homeDirectory}/.config/xremap/config.yml";
        Restart = "always";
        RestartSec = "3s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
