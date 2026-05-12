{ pkgs, username, config, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "Transmission";
  port = 9091;
  downloadDir = "/run/media/${username}/1000xhome/downloads";
  configDir = "/home/${username}/.config/transmission-daemon";
in
{
  home-manager.users.${username} = {
    systemd.user.services.transmission = {
      Unit = {
        Description = "Transmission BitTorrent Daemon";
        After = [ "network.target" ];
      };

      Service = {
        ExecStart = "${pkgs.transmission_4}/bin/transmission-daemon -f -g ${configDir}";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "default.target" ];
    };

    home.file."${configDir}/settings.json".text = builtins.toJSON {
      rpc-bind-address = "127.0.0.1";
      rpc-port = port;
      rpc-enabled = true;
      rpc-whitelist-enabled = false;
      rpc-authentication-required = false;
      download-dir = downloadDir;
      incomplete-dir-enabled = false;
      umask = 2;
    };

    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "BitTorrent Client";
      exec = "${wrapper}/bin/chromium-browser --app=http://localhost:${toString port}";
      icon = "transmission";
      terminal = false;
      categories = [ "Network" ];
    };
  };
}
