{ config, pkgs, ... }:

{
  fileSystems."/var/lib/slskd/music" = {
    device = "/mnt/1000xlab/backup-everything/FB2K/Library Historyfied!";
    fsType = "none";
    options = [ "bind" "ro" ];
  };

  sops.secrets."slskd/password" = { };
  sops.secrets."slskd/web-app-password" = { };

  sops.templates."slskd.yml" = {
    mode = "0640";
    group = "slskd";
    restartUnits = [ "slskd.service" ];
    content = ''
      soulseek:
        username: lewelove
        password: ${config.sops.placeholder."slskd/password"}
        listen_port: 50300
        description: "350GB music library, open ports, online 24/7, look inside"

      shares:
        directories:
          - "/var/lib/slskd/music"

      directories:
        downloads: /mnt/1000xlab/downloads/slskd/complete
        incomplete: /mnt/1000xlab/downloads/slskd/incomplete

      transfers:
        upload:
          slots: 20
          speed_limit: 2048
        download:
          slots: 3

      web:
        port: 5030
        ip_address: "0.0.0.0"
        https:
          disabled: true
        authentication:
          disabled: false
          username: lewelove
          password: ${config.sops.placeholder."slskd/web-app-password"}
    '';
  };

  users.users.slskd = {
    isSystemUser = true;
    group = "slskd";
    home = "/home/slskd";
    createHome = true;
  };
  users.groups.slskd = { };

  systemd.services.slskd = {
    description = "slskd (Soulseek)";
    after = [
      "network.target"
      "local-fs.target"
      "sops-install-secrets.service"
    ];
    wants = [ "sops-install-secrets.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = [
        "+${pkgs.coreutils}/bin/install -d -o slskd -g torrents -m 2770 /mnt/1000xlab/downloads/slskd /mnt/1000xlab/downloads/slskd/complete /mnt/1000xlab/downloads/slskd/incomplete"
      ];
      ExecStart = "${pkgs.slskd}/bin/slskd --config ${config.sops.templates."slskd.yml".path}";
      User = "slskd";
      Group = "slskd";
      UMask = "0002";
      Restart = "on-failure";
      RestartSec = "10";
      SupplementaryGroups = [ "torrents" "users" "wheel" "jellyfin" ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 50300 5030 ];
    allowedUDPPorts = [ 50300 5030 ];
  };
}

