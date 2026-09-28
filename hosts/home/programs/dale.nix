{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  dot = config.my.identity.dotfilesPath;
  wrapper = config.my.chromium.wrapper;
  name = "Dale";
  icon = "dale";
  domain = "localhost";

  dale-cmd = pkgs.writeShellScriptBin "dale" ''
    case "$1" in
      ui)
        cd "/home/${user}/dev/dale/web-app" && exec ${pkgs.bun}/bin/bun run dev
        ;;
      *)
        exec "/home/${user}/dev/dale/target/release/dale" "$@"
        ;;
    esac
  '';
in
{
  environment.systemPackages = [
    pkgs.bun
    dale-cmd
  ];

  home-manager.users.${user} = { config, ... }: {
    home.file.".config/dale".source = config.lib.file.mkOutOfStoreSymlink "${dot}/.config/dale";

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
