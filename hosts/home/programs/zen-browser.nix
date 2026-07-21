{ username, ... }:

{
  home-manager.users.${username} = { inputs, ... }: {
    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;

      profiles.default.presets.betterfox.enable = true;
      profiles.default.presets.arkenfox.enable = true;
    };
  };
}
