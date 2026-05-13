{ pkgs, username, dot, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      grim
      slurp
      waybar
    ];
  };

  services.displayManager.sessionPackages = [ pkgs.sway ];

  home-manager.users.${username} = { config, ... }: {
    home.file = {
      ".config/sway".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/sway";
      ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/waybar";
    };
  };
}
