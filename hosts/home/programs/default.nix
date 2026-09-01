{ pkgs, inputs, stable, username, dot, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    unzip
    gcc
    tree
    tree-sitter
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
    cryptsetup
    brightnessctl
    ddcutil
    toml2json
    qrencode

    # Desktop
    fuzzel
    mako
    libnotify
    awww
    nemo
    cliphist
    xremap
    hyprshot
    hyprpicker
    wl-clipboard
    gnome-calculator
    gnome-clocks
    nicotine-plus
    # plugdata
    marktext
    zoxide

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
    tmux
    hyperfine
    lazygit
    git-filter-repo
    taplo
    yazi
    eza
    devenv

    # Programming Languages
    python3
    rustc
    cargo
    clippy
    rustup
    rustfmt

    # Virtualisation
    distrobox

    # Media
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
  ];

  programs.ssh.startAgent = true;
  programs.dconf.enable = true;

  programs.fuse.userAllowOther = true;

  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  home-manager.users.${username} = { config, ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "lab" = {
          HostName = "192.168.1.100";
          User = "lewelove";
          ForwardAgent = "yes";
        };
        "arch-vm" = {
           hostname = "127.0.0.1";
           port = 2222;
           user = "arch";
           proxyJump = "lab";
        };
      };
    };

    home.file = {
      ".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.bashrc";
      ".scripts".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.scripts";
      ".applications".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.applications";
      ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/starship.toml";
      ".config/mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/mimeapps.list";
      ".config/repomix".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/repomix";
    };
  };
}
