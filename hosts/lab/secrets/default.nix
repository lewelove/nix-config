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

    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      "xray/uuid" = {};
      "xray/private_key" = {};
      "xray/short_id" = {};
      "duckdns/domain" = {};
      "dns/auth_key" = {};
    };
  };
}
