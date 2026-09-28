{ config, inputs, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
in
{
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup"; 
    users.${user} = { config, ... }: {
      home.stateVersion = "25.05";
      
      home.file = {
        ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/fish";
        ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/starship.toml";
      };
    };
  };
}
