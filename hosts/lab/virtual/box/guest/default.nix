{ config, ... }:

let
  user = config.my.identity.username;
in
{
  imports = [
    ../../../../../modules/core/identity.nix
    ./network.nix
    ./programs.nix
    ./user.nix
  ];

  my.identity.dotfilesPath = "/mnt/dotfiles";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      home.stateVersion = "26.05";
    };
  };

  system.stateVersion = "26.05";
  networking.hostName = "box";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.extraOptions = ''
    !include /home/${user}/.config/nix/nix.conf
  '';
}
