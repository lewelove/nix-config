{ pkgs, identity, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    config = {
      user = {
        name = identity.username;
        email = identity.email;
      };
      init.defaultBranch = "main";
      safe.directory = "*";
    };
  };
}
