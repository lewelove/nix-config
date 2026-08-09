{ config, pkgs, username, ... }:

let
  vmDir = "/home/${username}/virtual/arch";
  diskImage = "${vmDir}/arch.qcow2";
  sshPort = 2222;
  vncPort = 5900;
in
{
  boot.kernelModules = [ "kvm-intel" ];

  environment.systemPackages = [ pkgs.qemu_kvm ];

  networking.firewall.allowedTCPPorts = [ sshPort vncPort ];

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
      mkdir -p ${vmDir}/home
      if [ ! -f "${diskImage}" ]; then
        echo "Error: ${diskImage} not found. Run fetch-image.fish first."
        exit 1
      fi
      chown -R ${username}:users ${vmDir}
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
        -serial mon:stdio \
        -virtfs local,path=${vmDir}/home,mount_tag=host_home,security_model=mapped-xattr,id=host_home
    '';
  };
}

