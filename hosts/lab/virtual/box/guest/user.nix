{ pkgs, ... }:

{
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

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/box/.ssh 0700 box users -"
  ];
}
