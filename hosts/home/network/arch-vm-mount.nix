{ username, ... }:

{
  fileSystems."/home/${username}/virtual/arch" = {
    device = "arch@127.0.0.1:/home/arch";
    fsType = "fuse.sshfs";
    options = [
      "x-systemd.automount"
      "noatime"
      "_netdev"
      "port=2222"
      "ProxyJump=lewelove@192.168.1.100"
      "IdentityFile=/home/${username}/.ssh/id_ed25519"
      "StrictHostKeyChecking=no"
      "UserKnownHostsFile=/dev/null"
      "reconnect"
      "ServerAliveInterval=15"
      "ServerAliveCountMax=3"
      "allow_other"
    ];
  };
}

