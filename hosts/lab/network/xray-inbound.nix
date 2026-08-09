{ config, pkgs, ... }:

{
  # Open inbound port in firewall
  networking.firewall.allowedTCPPorts = [ 8443 ];

  # Render Xray configuration with secrets using sops templates
  sops.templates."xray-inbound.json" = {
    owner = "nobody";
    content = ''
      {
        "log": {
          "loglevel": "warning"
        },
        "inbounds": [
          {
            "listen": "0.0.0.0",
            "port": 8443,
            "protocol": "vless",
            "settings": {
              "clients": [
                {
                  "id": "${config.sops.placeholder."xray/uuid"}",
                  "flow": "xtls-rprx-vision"
                }
              ],
              "decryption": "none"
            },
            "streamSettings": {
              "network": "tcp",
              "security": "reality",
              "realitySettings": {
                "show": false,
                "dest": "dl.google.com:443",
                "xver": 0,
                "serverNames": [
                  "dl.google.com",
                  "www.google.com"
                ],
                "privateKey": "${config.sops.placeholder."xray/private_key"}",
                "shortIds": [
                  "${config.sops.placeholder."xray/short_id"}"
                ]
              }
            }
          }
        ],
        "outbounds": [
          {
            "tag": "direct",
            "protocol": "freedom"
          },
          {
            "tag": "v2raya-proxy",
            "protocol": "socks",
            "settings": {
              "servers": [
                {
                  "address": "127.0.0.1",
                  "port": 20170
                }
              ]
            }
          }
        ],
        "routing": {
          "domainStrategy": "IPIfNonMatch",
          "rules": [
            {
              "type": "field",
              "ip": [
                "192.168.0.0/16",
                "10.0.0.0/8",
                "172.16.0.0/12",
                "127.0.0.0/8"
              ],
              "outboundTag": "direct"
            },
            {
              "type": "field",
              "network": "tcp,udp",
              "outboundTag": "v2raya-proxy"
            }
          ]
        }
      }
    '';
  };

  # Systemd service running Xray with rendered secret config
  systemd.services.xray-inbound = {
    description = "Xray Inbound VLESS-Reality Server";
    after = [ "network.target" "v2raya.service" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.xray}/bin/xray -config ${config.sops.templates."xray-inbound.json".path}";
      Restart = "always";
      RestartSec = "3s";
      User = "nobody";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
    };
  };
}
