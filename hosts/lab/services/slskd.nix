{ config, pkgs, ... }:

{
  sops.secrets."slskd/password" = { };
  sops.secrets."slskd/web-app-password" = { };

  sops.templates."slskd.env" = {
    mode = "0640";
    group = "slskd";
    restartUnits = [ "slskd.service" ];
    content = ''
      SLSKD_SLSK_USERNAME=lewelove
      SLSKD_SLSK_PASSWORD=${config.sops.placeholder."slskd/password"}
      SLSKD_USERNAME=lewelove
      SLSKD_PASSWORD=${config.sops.placeholder."slskd/web-app-password"}
    '';
  };

  services.slskd = {
    enable = true;
    environmentFile = config.sops.templates."slskd.env".path;
    openFirewall = true;

    settings = {
      soulseek = {
        listen_port = 50300;
        description = "350GB music library, open ports, online 24/7, look inside";
      };

      shares.directories = [
        "/mnt/1000xlab/backup-everything/FB2K/Library Historyfied!"
      ];

      directories = {
        downloads = "/mnt/1000xlab/downloads/slskd/complete";
        incomplete = "/mnt/1000xlab/downloads/slskd/incomplete";
      };

      transfers = {
        upload = {
          slots = 20;
          speed_limit = 2048;
        };
        download.slots = 3;
      };

      web = {
        port = 5030;
        https.disabled = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 5030 ];
}

