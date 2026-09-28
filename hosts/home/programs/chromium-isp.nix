{ pkgs, config, ... }:

let
  user = config.my.identity.username;
  chromium-isp = pkgs.writeShellScriptBin "chromium-isp" ''
    exec sg novpn -c "${config.my.chromium.wrapper}/bin/chromium-browser \
      --user-data-dir=\$HOME/.config/chromium-isp \
      --disable-background-mode \
      --reduce-user-agent-data-linux-platform-version \
      --remove-client-hints \
      $*"
  '';
in
{
  environment.systemPackages = [ chromium-isp ];

  home-manager.users.${user} = {
    xdg.desktopEntries.chromium-isp = {
      name = "Chromium (ISP)";
      genericName = "Web Browser";
      comment = "Bypass the VPN via ISP gateway using a separate profile";
      exec = "chromium-isp %U";
      icon = "chromium";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };
}
