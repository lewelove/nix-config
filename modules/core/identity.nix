{ lib, ... }:

{
  options.my.identity = {

    username = lib.mkOption {
      type = lib.types.str;
      default = "lewelove";
      description = "Primary user account name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "lewelove@proton.me";
      description = "Primary email address";
    };

    repoPath = lib.mkOption {
      type = lib.types.str;
      default = "/home/lewelove/nix-config";
      description = "Absolute path to local nix-config git checkout";
    };
  };
}
