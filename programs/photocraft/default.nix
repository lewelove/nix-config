{ pkgs, lib, config, ... }:

let
  user = config.my.identity.username;

  runtimeLibs = with pkgs; [
    wayland
    wayland-protocols
    libxkbcommon
    libGL
    vulkan-loader
    libX11
    libXcursor
    libXi
    libXrandr
  ];

  photocraft = pkgs.writeShellScriptBin "photocraft" ''
    export WGPU_BACKEND="vulkan"
    export LD_LIBRARY_PATH="${lib.makeLibraryPath runtimeLibs}:/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    exec "/home/${user}/dev/cloned/photocraft/target/release/photocraft" "$@"
  '';
in
{
  environment.systemPackages = [ photocraft ];

  home-manager.users.${user} = {
    xdg.desktopEntries.photocraft = {
      name = "PhotoCraft";
      genericName = "Image Editor";
      comment = "Clean-room Photoshop clone in Rust";
      exec = "photocraft %F";
      icon = "photocraft";
      terminal = false;
      categories = [ "Graphics" "Photography" ];
    };
  };
}
