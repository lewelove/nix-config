{ config, pkgs, inputs, username, ... }:

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

    age.sshKeyPaths = [ "/home/${username}/.ssh/id_ed25519" ];

    secrets."sops-test" = {
      path = "/home/${username}/sops-test.txt";
      owner = username;
    };
  };
}
