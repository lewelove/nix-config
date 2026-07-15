{ pkgs, lib, username, ... }:

{
  services.flatpak.packages = [
    "com.bitwarden.desktop"
  ];
}
