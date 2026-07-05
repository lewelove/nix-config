{ pkgs, username, config, ... }:

let
  windowUserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36";
  chromium-isp = pkgs.writeShellScriptBin "chromium-isp" ''
    exec sg novpn -c "${config.my.chromium.wrapper}/bin/chromium-browser \
      --user-data-dir=\$HOME/.config/chromium-isp \
      --disable-background-mode \
      --reduce-user-agent-data-linux-platform-version \
      --remove-client-hints \
      $*"
  '';

# --user-agent='${windowUserAgent}' \

in
{
  environment.systemPackages = [ chromium-isp ];

  home-manager.users.${username} = {
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
