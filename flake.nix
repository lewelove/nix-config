{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    import-tree.url = "github:vic/import-tree";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
  let
    system = "x86_64-linux";
    mkHost = { hostname, modules ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/${hostname}
        ] ++ modules;
      };
  in {
    nixosConfigurations = {
      home = mkHost {
        hostname = "home";
      };

      lab = mkHost {
        hostname = "lab";
        modules = [
          inputs.disko.nixosModules.disko
        ];
      };

      box = mkHost {
        hostname = "box";
        modules = [
          inputs.microvm.nixosModules.microvm
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
