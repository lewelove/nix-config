{ pkgs, username, dot, config, ... }:

let
  web-app-wrapper = config.my.chromium.wrapper;
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  home-manager.users.${username} = { config, ... }: {
    home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/hypr";

    xdg.desktopEntries.hyprland-wiki = {
      name = "Hyprland Wiki";
      exec = "${web-app-wrapper}/bin/chromium-browser --app=https://wiki.hypr.land";
      terminal = false;
    };

    systemd.user.targets.hyprland-session = {
      Unit = {
        Description = "Hyprland Compositor Session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
  };
}
