{ inputs, config, ... }:

let
  user = config.my.identity.username;
in
{
  imports = [
    # ../../core/dotfiles.nix
    # ../../core/identity.nix
    (inputs.import-tree ../../core)
    ./network.nix
    ./programs.nix
    ./user.nix
  ];

  boot.kernel.sysctl = {
    "vm.vfs_cache_pressure" = 300;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 10;
  };

  my.identity.repoPath = "/mnt/nix-config";
  my.identity.dotfilesPath = "/mnt/nix-config/dotfiles";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${user} = {
      home.stateVersion = "26.05";
      home.activationGenerateGcRoot = false;
    };
  };

  system.stateVersion = "26.05";
  networking.hostName = "box";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.extraOptions = ''
    !include /home/${user}/.config/nix/nix.conf
  '';
}
