{ inputs, pkgs, config, ... }:

let
  user = config.my.identity.username;
in
{
  imports = [
    inputs.microvm.nixosModules.host
  ];

  boot.kernelModules = [ "kvm-intel" ];

  networking.firewall.allowedTCPPorts = [ 2223 ];

  systemd.tmpfiles.rules = [
    "d /home/${user}/virtual/box 0755 ${user} users -"
    "d /home/${user}/virtual/box/.config/nix 0755 ${user} users -"
    "L+ /mnt/dotfiles - - - - ${config.my.identity.repoPath}/dotfiles"
  ];

  sops.templates."box-nix-access-tokens" = {
    path = "/home/${user}/virtual/box/.config/nix/nix.conf";
    owner = user;
    group = "users";
    mode = "0644";
    content = ''
      access-tokens = github.com=${config.sops.placeholder."github-token"}
    '';
  };

  microvm.vms.box = {
    autostart = true;
    config = {
      imports = [
        inputs.home-manager.nixosModules.default
        ./guest
      ];

      microvm = {
        hypervisor = "qemu";
        vcpu = 2;
        mem = 4096;

        shares = [
          {
            proto = "virtiofs";
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
            readOnly = true;
          }
          {
            proto = "virtiofs";
            tag = "dotfiles";
            source = "${config.my.identity.repoPath}/dotfiles";
            mountPoint = "/mnt/dotfiles";
            readOnly = true;
          }
          {
            proto = "virtiofs";
            tag = "home-box";
            source = "/home/${user}/virtual/box";
            mountPoint = "/home/${user}";
          }
        ];

        volumes = [
          {
            image = "/var/lib/microvms/box/box-store-overlay.img";
            mountPoint = "/nix/.rw-store";
            size = 40960;
            fsType = "ext4";
            autoCreate = true;
          }
        ];

        writableStoreOverlay = "/nix/.rw-store";

        interfaces = [
          {
            type = "user";
            id = "usernet";
            mac = "02:00:00:00:00:01";
          }
        ];

        forwardPorts = [
          {
            from = "host";
            host.port = 2223;
            guest.port = 22;
          }
        ];
      };
    };
  };
}
