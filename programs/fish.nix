{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
  };

  my.dotfiles.".config/fish" = "dotfiles/.config/fish";
}
