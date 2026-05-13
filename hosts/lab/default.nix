{ inputs, lib, ... }:

{

  imports = [

    # System
    ./system.nix
    ./user.nix

    # Network
    ./network/core.nix
    ./network/inbound.nix
    ./network/amneziawg.nix
    ./network/openssh.nix
    ./network/duckdns.nix
    ./network/reverse-proxy.nix
    ./network/fail2ban.nix
    ./network/auth.nix
    ./network/routing-isp.nix

    # Home Manager
    ./modules/home-manager.nix

    # Modules
    ./modules/hardware-configuration.nix
    ./modules/disko.nix

    ./modules/packages.nix
    ./modules/programs.nix

    ./modules/virtualization.nix

    # Programs
    ../../programs/fish.nix
    ../../programs/nvim.nix
    ../../programs/git.nix
    ../../programs/btop.nix

    # Services
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/disabled/" path))
      (i: i ./services)
    ])

    # Scripts
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/disabled/" path))
      (i: i ../../scripts)
    ])
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/disabled/" path))
      (i: i ./scripts)
    ])

    # Commercial
    ./commercial/family-office-bot.nix

  ];

}
