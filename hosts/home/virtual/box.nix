{ inputs, config, lib, ... }:

let
  user = config.my.identity.username;

  sharedProjects = [
    "cloned"
    "dale"
  ];

  mkDevShare = name: {
    microvm.shares = [
      {
        proto = "virtiofs";
        tag = "dev-${name}";
        source = "/home/${user}/dev/${name}";
        mountPoint = "/mnt/dev/${name}";
      }
    ];

    systemd.tmpfiles.rules = [
      "d /home/${user}/dev 0755 ${user} users -"
      "L+ /home/${user}/dev/${name} - - - - /mnt/dev/${name}"
    ];
  };
in
{
  imports = [
    inputs.microvm.nixosModules.host
  ];

  boot.kernelModules = [ "kvm-intel" ];

  networking.firewall.allowedTCPPorts = [ 2223 ];

  home-manager.users.${user}.programs.ssh.settings."box" = {
    hostname = "127.0.0.1";
    port = 2223;
    user = user;
  };

  systemd.tmpfiles.rules = [
    "d /home/${user}/virtual/box 0755 ${user} users -"
    "d /home/${user}/virtual/box/.config/nix 0755 ${user} users -"
    "d /home/${user}/dev 0755 ${user} users -"
  ] ++ (map (name: "d /home/${user}/dev/${name} 0755 ${user} users -") sharedProjects);

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
    specialArgs = { inherit inputs; };
    config = {
      imports = [
        inputs.home-manager.nixosModules.default
        ../../box
      ] ++ (map mkDevShare sharedProjects);

      microvm = {
        hypervisor = "qemu";
        qemu.extraArgs = [
          "-device"
          "virtio-balloon-pci,free-page-reporting=on"
        ];
        vcpu = 3;
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
            tag = "nix-config";
            source = config.my.identity.repoPath;
            mountPoint = "/mnt/nix-config";
            readOnly = true;
          }
          {
            proto = "virtiofs";
            tag = "home-box";
            source = "/home/${user}/virtual/box";
            mountPoint = "/home/${user}";
          }
          {
            proto = "virtiofs";
            tag = "photoshop-wine";
            source = "/home/${user}/.local/share/photoshop-wine/";
            mountPoint = "/mnt/photoshop-wine";
            readOnly = true;
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
          {
            image = "/var/lib/microvms/box/box-nix-var.img";
            mountPoint = "/nix/var";
            size = 4096;
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
