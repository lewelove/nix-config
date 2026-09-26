{ config, pkgs, ... }:

{
  services.forgejo = {
    enable = true;
    stateDir = "/var/lib/forgejo";

    settings = {
      server = {
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3001;
      };

      service = {
        DISABLE_REGISTRATION = true;
        REQUIRE_SIGNIN_VIEW = true;
      };

      repository = {
        DEFAULT_PRIVATE = "private";
        FORCE_PRIVATE = true;
      };
    };
  };

  sops.secrets."duckdns/domain" = { };

  sops.templates."forgejo.env" = {
    content = ''
      FORGEJO__server__DOMAIN=git.${config.sops.placeholder."duckdns/domain"}
      FORGEJO__server__ROOT_URL=https://git.${config.sops.placeholder."duckdns/domain"}
    '';
  };

  systemd.services.forgejo = {
    after = [ "sops-install-secrets.service" ];
    wants = [ "sops-install-secrets.service" ];
    serviceConfig.EnvironmentFile = [ config.sops.templates."forgejo.env".path ];
  };

  environment.systemPackages = [ pkgs.forgejo pkgs.tea ];
}

