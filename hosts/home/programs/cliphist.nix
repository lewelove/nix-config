{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
in
{
  environment.systemPackages = with pkgs; [
    cliphist
  ];

  home-manager.users.${user} = { config, ... }: {
    systemd.user.services.cliphist = {
      Unit = {
        Description = "Cliphist Daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    home.file.".config/cliphist".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/cliphist";
  };
}
