{ pkgs, lib, username, ... }:

{
  services.flatpak.packages = [
    "com.bitwarden.desktop"
  ];

  home-manager.users.${username} = {
    xdg.desktopEntries.bitwarden = {
      name = "Bitwarden";
      genericName = "Password Manager";
      comment = "Secure password manager";
      exec = "flatpak run com.bitwarden.desktop";
      icon = "bitwarden";
      terminal = false;
      categories = [ "Utility" ];
    };
  };
}
