{ pkgs, inputs, stable, ... }:

{
  environment.systemPackages = with pkgs;[

    # System
    wget
    unzip
    gcc
    tree
    killall
    jq
    jaq
    yq-go
    ydotool
    wtype
    wev
    xhost
    pulseaudio
    gnome-disk-utility
    sshfs
    tcpdump
    mkcert
    mesa-demos
    waffle
    apitrace
    openssl

    # Desktop
    fuzzel
    mako
    libnotify
    awww
    xremap
    hyprshot
    hyprpicker
    wl-clipboard
    bitwarden-desktop
    gnome-calculator
    gnome-clocks
    nicotine-plus
    plugdata

    # Terminal Programs
    foot
    kitty
    alacritty
    btop
    repomix
    ripgrep
    bat
    fd
    fastfetch
    starship
    hyperfine
    lazygit
    git-filter-repo
    taplo
    amneziawg-tools

    # Virtualization
    distrobox

    # Media
    stable.mpv
    imv
    mpc
    rmpc
    flac
    flac2all
    mediainfo
    imagemagick
    puddletag
    roomeqwizard
    transmission_4
    ffmpeg
    intermodal
    aria2

    # Web
    ayugram-desktop

    # Themes and Icons
    nwg-look
    adwaita-icon-theme
    
    # Nix
    nh
    nvd
    nix-output-monitor

    # Flake Inputs
    inputs.nvibrant.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
