{ config, ... }:

let
  user = config.my.identity.username;
in
{
  home-manager.users.${user} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
  };
}
