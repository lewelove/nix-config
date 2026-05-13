{ pkgs, username, dot, ... }:

{
  programs.thunar.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
}
