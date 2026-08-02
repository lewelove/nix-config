{
  description = "Entry Point for NixOS Configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    hyprland-git = {
      # url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/pull/15716/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          config = {
            allowUnfree = true;
          };
        };
      };
      modules = [ ./default.nix ];
    };
  };
}
