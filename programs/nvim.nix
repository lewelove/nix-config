{ pkgs, config, lib, ... }:

let
  cfg = config.my.programs.neovim;
  user = config.my.identity.username;
  dotfiles = config.my.identity.dotfilesPath;

  nv = pkgs.writeShellScriptBin "nv" ''
    exec ${pkgs.neovim}/bin/nvim "$@"
  '';

  nvl = pkgs.writeShellScriptBin "nvl" ''
    exec ${pkgs.alacritty}/bin/alacritty --class "nvim" -e ${pkgs.neovim}/bin/nvim "$@"
  '';

  desktopItem = pkgs.makeDesktopItem {
    name = "nvl";
    desktopName = "Neovim (Launcher)";
    genericName = "Text Editor";
    comment = "Edit text files in Neovim";
    exec = "nvl %F";
    icon = "nvim";
    terminal = false;
    categories = [ "Utility" "TextEditor" "Development" ];
  };
in
{
  options.my.programs.neovim = {
    enable = lib.mkEnableOption "Neovim text editor";
    gui = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Alacritty GUI wrapper and desktop entry";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.neovim
      pkgs.tree-sitter
      nv
    ] ++ lib.optionals cfg.gui [
      nvl
      desktopItem
    ];

    home-manager.users.${user} = { config, ... }: {
      home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
    };
  };
}
