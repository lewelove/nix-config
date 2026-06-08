{ pkgs, lib, username, config, dot, ... }:

let
  wrapper = config.my.chromium.wrapper;
  url = "https://figma.com";
  name = "Figma";
in
{
  home-manager.users.${username} = { config, ... }: {
    xdg.desktopEntries.${name} = {
      inherit name;
      genericName = "Graphic Design Tool";
      exec = "${wrapper}/bin/chromium-browser --app=${url}";
      terminal = false;
      icon = "figma";
      categories = [ "Graphics" "Network" ];
    };

    systemd.user.services.figma-agent = {
      Unit = {
        Description = "Figma Agent for Linux";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.figma-agent}/bin/figma-agent";
        Restart = "on-failure";
        RestartSec = "5s";
        Environment = [ "BIND=127.0.0.1:44950" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    home.file.".config/figma-agent".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/figma-agent";
  };
}
