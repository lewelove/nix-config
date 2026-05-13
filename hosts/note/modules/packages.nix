{ pkgs, inputs, stable, ... }:

{
  environment.systemPackages = with pkgs; [

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
    waffle
    apitrace
    openssl

    # Desktop
    fuzzel
    mako
    libnotify
    wl-clipboard
    bitwarden-desktop

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

    # Media
    stable.mpv
    # imv
    # mpc
    # rmpc
    # flac
    # flac2all
    # mediainfo
    # qbittorrent
    # transmission_4
    
    # Web
    ayugram-desktop

    # Themes and Icons
    nwg-look
    adwaita-icon-theme
    
    # Nix
    nh
    nvd
    nix-output-monitor

  ];
}
