{ pkgs, config, ... }:

let
  user = config.my.identity.username;
in
{
  home-manager.users.${user} = {
    systemd.user.services.polkit-agent = {
      Unit = {
        Description = "GNOME Polkit Authentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
