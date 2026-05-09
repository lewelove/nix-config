{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.mirotalk = {
    image = "mirotalk/p2p:latest";
    ports = [ "127.0.0.1:3000:3000" ];
  };
}
