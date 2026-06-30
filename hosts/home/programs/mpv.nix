{ stable, username, dot, config, ... }:

{
  environment.systemPackages = [
    (stable.mpv.override {
      mpv-unwrapped = stable.mpv-unwrapped.override {
        sdl2Support = true;
      };
    })
  ];

  home-manager.users.${username} = { config, osConfig, ... }: {
    home.file.".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/mpv";

    xdg.desktopEntries.mpv-wiki = let
      web-app-wrapper = osConfig.my.chromium.wrapper;
      name = "Mpv Wiki";
      url = "https://mpv.io/manual/stable/";
    in {
      inherit name;
      exec = "${web-app-wrapper}/bin/chromium-browser --app=${url}";
      terminal = false;
    };
  };
}
