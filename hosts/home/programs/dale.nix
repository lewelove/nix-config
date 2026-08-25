{ pkgs, lib, username, config, identity, ... }:

let
  wrapper = config.my.chromium.wrapper;
  name = "Dale";
  icon = "dale";
  domain = "localhost";

  dale-cmd = pkgs.writeShellScriptBin "dale" ''
    case "$1" in
      ui)
        cd "/home/${username}/dev/dale/web-app" && exec ${pkgs.bun}/bin/bun run dev
        ;;
      *)
        exec "/home/${username}/dev/dale/target/release/dale" "$@"
        ;;
    esac
  '';
in
{

  environment.systemPackages = [
    pkgs.bun
    dale-cmd
  ];

  home-manager.users.${username} = { config, ... }: {
    home.file.".config/dale".source = config.lib.file.mkOutOfStoreSymlink "${identity.repoPath}/dotfiles/.config/dale";

    xdg.desktopEntries.${name} = {
      inherit name icon;
      exec = "${wrapper}/bin/chromium-browser --app=http://${domain}:4173";
      terminal = false;
    };

    xdg.desktopEntries."${name}-dev" = {
      inherit icon;
      name = "${name} Dev";
      exec = "${wrapper}/bin/chromium-browser --app=http://${domain}:5173";
      terminal = false;
    };

  };
}
