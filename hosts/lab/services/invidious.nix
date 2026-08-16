{ config, pkgs, ... }:

let
  companionKey = "aB3k9Xm2P7qR4vW8";
in
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.invidious-companion = {
      image = "quay.io/invidious/invidious-companion:latest";
      autoStart = true;
      extraOptions = [
        "--network=host"
      ];
      environment = {
        SERVER_SECRET_KEY = companionKey;
        HTTP_PROXY = "http://127.0.0.1:20171";
        HTTPS_PROXY = "http://127.0.0.1:20171";
        ALL_PROXY = "socks5://127.0.0.1:20170";
      };
    };
  };

  services.invidious = {
    enable = true;
    port = 3030;

    settings = {

      http_proxy = {
        type = "socks5";
        host = "127.0.0.1";
        port = 20170;
      };

      registration_enabled = false;

      invidious_companion = [
        {
          private_url = "http://127.0.0.1:8282/companion";
        }
      ];
      invidious_companion_key = companionKey;
    };
  };

  systemd.services.invidious = {
    after = [ "v2raya.service" "podman-invidious-companion.service" ];
    wants = [ "v2raya.service" "podman-invidious-companion.service" ];
  };
}
