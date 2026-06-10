{ username, dot, ... }:

{
  home-manager.users.${username} = { config, pkgs, ... }: {
    home.file.".config/xremap/".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/xremap/";

    systemd.user.services.xremap = {
      Unit = {
        Description = "xremap keyboard remapper";
        After = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.xremap}/bin/xremap --device \"SEM USB Keyboard\" --device \"Xbox Wireless Controller\" ${config.home.homeDirectory}/.config/xremap/config.yml";
        Restart = "always";
        RestartSec = "3s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
