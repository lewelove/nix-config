{ config, pkgs, inputs, username, lib, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    age.sshKeyPaths = lib.mkDefault [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
}
