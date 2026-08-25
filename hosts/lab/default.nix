{ inputs, lib, ... }:

{

  imports = [

    # System
    ./system.nix
    ./user.nix

    # Secrets
    ./secrets

    # Virtual Machines
    # ./virtual/arch

    # Home Manager
    ./modules/home-manager.nix

    # Modules
    ./modules/hardware-configuration.nix
    ./modules/disko.nix
    ./modules/virtualization.nix

    # Network
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./network)
    ])

    # Programs
    ../../programs/fish.nix
    ../../programs/nvim.nix
    ../../programs/git.nix
    ../../programs/btop.nix
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./programs)
    ])

    # Services
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./services)
    ])

    # Scripts
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ../../scripts)
    ])
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./scripts)
    ])

    # Commercial
    # ./commercial/family-office-bot.nix

  ];

}
