{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
in
{
  home-manager.users.${user} = { config, ... }: {
    systemd.user.services.quickshell = {
      Unit = {
        Description = "Quickshell Desktop Shell";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.quickshell}/bin/quickshell -p %h/.config/quickshell/hypr-ref/shell.qml";
        Restart = "on-failure";
        Environment = [
          "QSG_DISTANCEFIELD_ANTIALIASING=subpixel"
        ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    home.file.".config/quickshell".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/quickshell";
  };
}
