{ pkgs, config, ... }:

{
  imports = [
    ../../programs/nvim
    ../../programs/fish.nix
    ../../programs/starship.nix
    ../../programs/direnv.nix
    ../../programs/git.nix
    ../../programs/btop.nix
  ];

  my.programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    pi-coding-agent
    devenv
    git
    zoxide
    eza
    yazi
    lazygit
    rustup
    python3
  ];
}
