{ config, lib, ... }:

{
  options.my.dotfiles = lib.mkOption {
    type = lib.types.attrsOf (lib.types.either lib.types.path lib.types.str);
    default = {};
    description = "Map of home-relative targets to source paths or repo-relative strings";
  };

  config.home-manager.users.${config.my.identity.username}.home.file =
    lib.mapAttrs' (target: src:
      let
        pathStr =
          if builtins.isPath src
          then "${config.my.identity.repoPath}${lib.removePrefix (toString ../.) (toString src)}"
          else if lib.hasPrefix "/" src
          then src
          else "${config.my.identity.repoPath}/${src}";
      in
      lib.nameValuePair target {
        source = config.home-manager.users.${config.my.identity.username}.lib.file.mkOutOfStoreSymlink pathStr;
      }
    ) config.my.dotfiles;
}
