{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.superfile ];

  my.dotfiles.".config/superfile" = ./config;
}

