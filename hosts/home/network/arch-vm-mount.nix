{ pkgs, username, ... }:

let
  mountpoint = "/home/${username}/virtual/arch";
in
{
  systemd.user.services.arch-vm-mount = {
    description = "Mount the arch VM home via sshfs";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountpoint}";
      ExecStart = "${pkgs.sshfs}/bin/sshfs -f -o ProxyJump=lewelove@192.168.1.100 -o port=2222,reconnect -o ServerAliveInterval=15,ServerAliveCountMax=3 -o StrictHostKeyChecking=no,UserKnownHostsFile=/dev/null -o noatime arch@127.0.0.1:/home/arch ${mountpoint}";
      ExecStop = "-${pkgs.fuse3}/bin/fusermount3 -u ${mountpoint}";
    };
  };
}

