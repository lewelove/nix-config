{ stable, username, dot, ... }:

{
  environment.systemPackages = [
    (stable.mpv.override {
      mpv-unwrapped = stable.mpv-unwrapped.override {
        sdl2Support = true;
      };
    })
  ];

  home-manager.users.${username} = { config, ... }: {
    home.file.".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/mpv";
  };
}
