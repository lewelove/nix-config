{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
in
{
  programs.fish = {
    enable = true;
  };

  home-manager.users.${user} = { config, ... }: {
    home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/fish";
  };
}
