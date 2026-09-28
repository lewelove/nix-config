{ pkgs, config, ... }:

let
  user = config.my.identity.username;
in
{
  imports = [
    ../../programs/nvim
  ];

  my.programs.neovim.enable = true;

  programs.fish.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pi-coding-agent
    devenv
    git
    starship
    zoxide
    eza
    yazi
    lazygit
  ];

  systemd.tmpfiles.rules = [
    "d /home/${user}/.config 0755 ${user} users -"
    "L+ /home/${user}/.config/fish - ${user} users - /mnt/dotfiles/.config/fish"
    "L+ /home/${user}/.config/starship.toml - ${user} users - /mnt/dotfiles/.config/starship.toml"
  ];
}
