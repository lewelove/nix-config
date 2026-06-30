{ pkgs, username, dot, config, ... }:

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

  home-manager.users.${username} = { config, osConfig, ... }: {
    home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/hypr";

    xdg.desktopEntries.hyprland-wiki = let
      web-app-wrapper = osConfig.my.chromium.wrapper;
      name = "Hyprland Wiki";
      url = "https://wiki.hypr.land";
    in {
      inherit name;
      exec = "${web-app-wrapper}/bin/chromium-browser --app=${url}";
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
