{ inputs, lib, ... }:

{
  imports = [

    # System
    ./system.nix
    ./user.nix

    # Secrets
    ../../secrets

    # Modules
    ./modules/boot.nix
    ./modules/environment.nix

    ./modules/hardware-configuration.nix
    ./modules/nvidia.nix

    ./modules/tilde.nix
    ./modules/bluetooth.nix
    ./modules/virtualization.nix

    ./modules/home-manager.nix
    ./modules/theme.nix

    ./modules/games.nix

    # Programs
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ../../programs)
    ])
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./programs)
    ])

    # Services
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ../../services)
    ])
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

    # Network
    (lib.pipe inputs.import-tree [
      (i: i.filterNot (path: lib.hasInfix "/d/" path))
      (i: i ./network)
    ])

  ];
}
