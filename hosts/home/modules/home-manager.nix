{ inputs, username, ... }:

{
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
    backupFileExtension = "backup"; 
    users.${username} = { config, ... }: {
      home.stateVersion = "26.05";

      xdg.userDirs = {
        enable = true;
        setSessionVariables = true;
        createDirectories = true;
        download = "/run/media/${username}/1000xhome/downloads";
      };
    };
  };
}
