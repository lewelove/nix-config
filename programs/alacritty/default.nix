{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.alacritty ];

  my.dotfiles.".config/alacritty" = ./config;
}
