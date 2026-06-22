{ pkgs, inputs, stable, username, dot, ... }:

{

  programs.ydotool.enable = true;

  users.users.${username} = {
    extraGroups = [ "ydotool" ];
  };

}
