{ pkgs, identity, ... }:

let
  awgu = pkgs.writeShellApplication {
    name = "awgu";
    runtimeInputs = with pkgs; [ 
      coreutils 
      findutils 
      gum 
      iputils
      amneziawg-go
      amneziawg-tools 
      psmisc
      jq
      curl
    ];
    text = ''
      if [ "$EUID" -ne 0 ]; then
        exec sudo "$0" "$@"
      fi

      SOURCE_DIR="/home/${identity.username}/vpn/amneziawg"
      TARGET_DIR="/etc/amneziawg"
      TARGET_CONF="$TARGET_DIR/active.conf"

      if [ ! -d "$SOURCE_DIR" ]; then
        echo "Error: Directory $SOURCE_DIR does not exist."
        exit 1
      fi

      SELECTED=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.conf" -printf "%f\n" | gum choose --header "Select VPN Endpoint")

      if [ -z "$SELECTED" ]; then
        exit 0
      fi

      echo ":: Switching to $SELECTED..."

      awg-quick down "$TARGET_CONF" 2>/dev/null || true
      killall amneziawg-go 2>/dev/null || true
      
      mkdir -p "$TARGET_DIR"
      ln -sf "$SOURCE_DIR/$SELECTED" "$TARGET_CONF"

      awg-quick up "$TARGET_CONF" 2>/dev/null || true

      # FIX PRIORITY INVERSION: Force wg-quick rules to evaluate AFTER the Steam bypass.
      while ip rule show | grep -q "lookup 51820"; do
          ip rule del lookup 51820 || true
      done
      while ip rule show | grep -q "suppress_prefixlength 0"; do
          ip rule del suppress_prefixlength 0 || true
      done
      
      ip rule add not fwmark 0xca6c table 51820 priority 32760 || true
      ip rule add table main suppress_prefixlength 0 priority 32759 || true

      echo ":: Verifying connection..."
      if ping -c 2 -w 2 1.1.1.1 >/dev/null 2>&1 || \
         ping -c 2 -w 2 8.8.8.8 >/dev/null 2>&1 || \
         ping -c 2 -w 2 77.88.8.8 >/dev/null 2>&1; then
        echo ""
        echo ":: SUCCESS: Tunnel LIVE"
        echo ":: Config: $SELECTED"
        
        if INFO=$(curl -s --interface active --max-time 2 http://ip-api.com/json 2>/dev/null); then
          IP=$(echo "$INFO" | jq -r .query 2>/dev/null || echo "Unknown")
          COUNTRY=$(echo "$INFO" | jq -r .country 2>/dev/null || echo "Unknown")
          echo ":: VPN IP: $IP ($COUNTRY)"
        fi
      else
        echo ""
        echo ":: ERROR: Tunnel failed"
        exit 1
      fi
    '';
  };

  awgd = pkgs.writeShellApplication {
    name = "awgd";
    runtimeInputs = with pkgs; [ amneziawg-tools psmisc ];
    text = ''
      if [ "$EUID" -ne 0 ]; then
        exec sudo "$0" "$@"
      fi
      awg-quick down /etc/amneziawg/active.conf 2>/dev/null || true
      killall amneziawg-go 2>/dev/null || true
      echo "VPN Stopped"
    '';
  };
in
{
  environment.systemPackages = [ awgu awgd ];
}
