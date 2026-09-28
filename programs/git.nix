{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    config = {
      user = {
        name = config.my.identity.username;
        email = config.my.identity.email;
      };
      init.defaultBranch = "main";
      safe.directory = "*";
    };
  };
}
