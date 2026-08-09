{ pkgs, ... }:

{
  services.forgejo = {
    enable = true;
    stateDir = "/var/lib/forgejo";

    settings = {
      server = {
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3001;
        DOMAIN = "10.0.2.2";
        ROOT_URL = "http://10.0.2.2:3001/";
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

  environment.systemPackages = [ pkgs.tea ];
}

