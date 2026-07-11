{ pkgs, inputs, ... }:

let

  # v2rayN bootstrap util
  # use to update the rulesets
  # run after fresh install
  v2rayn-bootstrap = pkgs.writeShellScriptBin "v2rayn-bootstrap" ''

    BIN_DIR="$HOME/.local/share/v2rayN/bin"
    SRS_DIR="$BIN_DIR/srss"

    # .dat file fetch
    mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
    curl -L -O https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
    curl -L -O https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat

    # sing-box compiled rulesets fetch
    mkdir -p "$SRS_DIR" && cd "$SRS_DIR"
    curl -L -O https://raw.githubusercontent.com/2dust/sing-box-rules/rule-set-geosite/geosite-private.srs
    curl -L -O https://raw.githubusercontent.com/2dust/sing-box-rules/rule-set-geosite/geosite-cn.srs
    curl -L -O https://raw.githubusercontent.com/2dust/sing-box-rules/rule-set-geoip/geoip-cn.srs
  '';

in

{
  environment.systemPackages = with pkgs; [
    xray
    sing-box
    v2rayn
    v2rayn-bootstrap
  ];

  home-manager.users.${username} = { config, ... }: {
    home.file = {
      ".local/share/v2rayN/bin/xray".source = "${pkgs.xray}/bin/xray";
      ".local/share/v2rayN/bin/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
    };
  };
}
