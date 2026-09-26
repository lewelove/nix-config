{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Core C/C++ runtime
      stdenv.cc.cc.lib
      zlib

      # Graphics & Vulkan (wgpu, vulkano, etc.)
      vulkan-loader
      libGL
      libglvnd

      # Wayland & Input (winit Wayland backend)
      wayland
      wayland-protocols
      libxkbcommon

      # X11 (winit X11 fallback backend)
      libX11
      libXcursor
      libXi
      libXrandr
      libXrender
      libXinerama
      libXfixes
      libXext
      libxcb

      # Audio (cpal, rodio, pipewire)
      alsa-lib
      libpulseaudio
      pipewire

      # Networking & Assets
      openssl
      fontconfig
      freetype
    ];
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
  };
}
