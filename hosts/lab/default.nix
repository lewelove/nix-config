{ inputs, lib, ... }:

{

  imports = [

    # System
    ./system.nix
    ./user.nix

    # Network
    ./network/core.nix
    ./network/inbound.nix

    # ./network/amneziawg.nix
    ./network/v2raya.nix

    ./network/openssh.nix
    ./network/duckdns.nix
    ./network/reverse-proxy.nix
    ./network/fail2ban.nix
    ./network/auth.nix
    ./network/routing-isp.nix
    ./network/adguardhome.nix

    # Home Manager
    ./modules/home-manager.nix

    # Modules
    ./modules/hardware-configuration.nix
    ./modules/disko.nix

    ./modules/virtualization.nix

    # Programs
    ../../programs/fish.nix
    ../../programs/nvim.nix
    ../../programs/git.nix
    ../../programs/btop.nix
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/disabled/" path))
      (i: i ./programs)
    ])

    # Services
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/disabled/" path))
      (i: i ./services)
    ])

    Scripts
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
