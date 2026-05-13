{
  description = "Entry Point for NixOS Configuration";

  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # Other Flakes
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    xremap.url = "github:xremap/nix-flake";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
  let
    identity = import ./identity.nix;
    hostPath = "${identity.repoPath}/hosts/${identity.hostname}";
    dot = "${identity.repoPath}/dotfiles";
  in {
    nixosConfigurations.${identity.hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs identity hostPath dot;
        inherit (identity) username hostname repoPath;
        stable = import nixpkgs-stable {
          system = "x86_64-linux"; 
          config.allowUnfree = true;
        };
      };
      modules = [ 
        inputs.disko.nixosModules.disko
        ./default.nix 
      ];
    };
  };
}
