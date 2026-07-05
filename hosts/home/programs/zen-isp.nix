{ pkgs, inputs, username, ... }:

let
  zen-pkg = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  
  zen-isp = pkgs.writeShellScriptBin "zen-isp" ''
    exec sg novpn -c "${zen-pkg}/bin/zen-beta \
      --profile \$HOME/.zen/ISP.Profile \
      --no-remote \
      \$*"
  '';
in
{
  environment.systemPackages = [ zen-isp ];

  home-manager.users.${username} = {
    xdg.desktopEntries.zen-isp = {
      name = "Zen Browser (ISP)";
      genericName = "Web Browser";
      comment = "Bypass the VPN via ISP gateway using Zen Browser";
      exec = "zen-isp %U";
      icon = "zen";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };
}
