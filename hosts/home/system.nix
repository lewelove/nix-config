{ config, pkgs, username, hostname, ... }:

{
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  documentation = {
    enable = false;
    man.enable = false;
    man.cache.enable = false;
    nixos.enable = false;
  };

  services.logrotate.enable = false;

  hardware.uinput.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="uinput", MODE="0660"
    KERNEL=="event*", GROUP="input", MODE="0660"
  '';

  boot.kernelModules = [ "msr" ];

  systemd.services.disable-bd-prochot = {
    description = "Disable BD PROCHOT CPU Throttling Bug";
    after = [ "multi-user.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "multi-user.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.msr-tools}/bin/wrmsr -a 0x1FC 0x38005c";
    };
  };

  systemd.oomd.enable = false;
  systemd.sockets.systemd-oomd.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";
}
