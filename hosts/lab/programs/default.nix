{ pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [

    # System
    wget
    stow
    unzip
    gcc
    tree
    killall
    jq
    btop
    wol
    tcpdump
    net-tools
    wakeonlan

    # Terminal Programs
    starship

    # Virtualization
    distrobox
    runc
    crun

    # Rust Utils
    ripgrep
    bat
    fd
    fzf
    zoxide
    eza

    # Media
    mpc
    rmpc
    
  ];

}
