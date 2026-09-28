{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.starship ];

  my.dotfiles.".config/starship.toml" = "dotfiles/.config/starship.toml";
}
