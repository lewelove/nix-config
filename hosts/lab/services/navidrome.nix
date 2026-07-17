{ config, pkgs, ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      Address = "127.0.0.1";
      Port = 4533;
      MusicFolder = "/mnt/1000xlab/backup-everything/FB2K/Library Historyfied!";
      
      LogLevel = "info";
      DefaultTheme = "Dark";
      EnableDownloads = true;
      SessionTimeout = "720h";
      
      BaseUrl = "https://navidrome.{$DUCKDNS_DOMAIN}";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    SupplementaryGroups = [ "users" "wheel" "jellyfin" ]; 
  };
}
