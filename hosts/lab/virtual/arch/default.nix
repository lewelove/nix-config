{ config, pkgs, username, ... }:

let
  vmDir = "/home/${username}/virtual/arch";
  diskImage = "${vmDir}/arch.qcow2";
  sshPort = 2222;
  vncPort = 5900;
in
{
  boot.kernelModules = [ "kvm-intel" ];

  environment.systemPackages = [
    pkgs.qemu_kvm
    pkgs.sshfs
  ];

  networking.firewall.allowedTCPPorts = [ sshPort vncPort ];

  fileSystems."/home/${username}/virtual/arch/vm-home" = {
    device = "arch@127.0.0.1:/home/arch";
    fsType = "fuse.sshfs";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.requires=arch-vm.service"
      "x-systemd.after=arch-vm.service"
      "x-systemd.idle-timeout=60"
      "_netdev"
      "port=2222"
      "IdentityFile=/home/${username}/.ssh/id_ed25519"
      "StrictHostKeyChecking=no"
      "UserKnownHostsFile=/dev/null"
      "allow_other"
      "reconnect"
      "ServerAliveInterval=15"
      "ServerAliveCountMax=3"
    ];
  };

  systemd.services.arch-vm = {
    description = "Minimal Isolated Arch Linux QEMU VM";
    after = [ "network.target" "v2raya.service" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [ qemu_kvm coreutils ];

    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    preStart = ''
      if [ ! -f "${diskImage}" ]; then
        echo "Error: ${diskImage} not found. Run fetch-image.fish first."
        exit 1
      fi
      mkdir -p "${vmDir}"
      chown ${username}:users "${vmDir}"
      chown ${username}:users "${diskImage}"
    '';

    script = ''
      exec qemu-system-x86_64 \
        -enable-kvm \
        -cpu host \
        -smp 2 \
        -m 4096 \
        -drive file=${diskImage},format=qcow2,if=virtio \
        -netdev user,id=net0,hostfwd=tcp:0.0.0.0:${toString sshPort}-:22 \
        -device virtio-net-pci,netdev=net0 \
        -vnc 127.0.0.1:0 \
        -serial mon:stdio
    '';
  };
}
