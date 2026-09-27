{ inputs, pkgs, config, ... }:

{
  imports = [
    inputs.microvm.nixosModules.host
  ];

  boot.kernelModules = [ "kvm-intel" ];

  networking.firewall.allowedTCPPorts = [ 2223 ];

  systemd.tmpfiles.rules = [
    "d /home/lewelove/virtual/box 0755 lewelove users -"
    "d /home/lewelove/virtual/box/.config/nix 0755 lewelove users -"
    "L+ /mnt/dotfiles - - - - /home/lewelove/nix-config/dotfiles"
  ];

  sops.templates."box-nix-access-tokens" = {
    path = "/home/lewelove/virtual/box/.config/nix/nix.conf";
    owner = "lewelove";
    group = "users";
    mode = "0644";
    content = ''
      access-tokens = github.com=${config.sops.placeholder."github-token"}
    '';
  };

  microvm.vms.box = {
    autostart = true;
    config = {
      system.stateVersion = "26.05";
      networking.hostName = "box";

      programs.fish.enable = true;

      nix.extraOptions = ''
        !include /home/box/.config/nix/nix.conf
      '';

      environment.systemPackages = with pkgs; [
        pi-coding-agent
        git
        starship
        zoxide
        eza
        yazi
      ];

      systemd.tmpfiles.rules = [
        "d /home/box/.config 0755 box users -"
        "d /home/box/.ssh 0700 box users -"
        "L+ /home/box/.config/fish - box users - /mnt/dotfiles/.config/fish"
        "L+ /home/box/.config/starship.toml - box users - /mnt/dotfiles/.config/starship.toml"
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
            source = "/home/lewelove/nix-config/dotfiles";
            mountPoint = "/mnt/dotfiles";
            readOnly = true;
          }
          {
            proto = "virtiofs";
            tag = "home-box";
            source = "/home/lewelove/virtual/box";
            mountPoint = "/home/box";
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

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      users.users.box = {
        isNormalUser = true;
        uid = 1000;
        group = "users";
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINngwDtUZAiEALEZ1XhPXX221hYqjGSaqWRnvaUnpMXT lewelove@proton.me"
        ];
      };

      security.sudo.wheelNeedsPassword = false;
    };
  };
}
