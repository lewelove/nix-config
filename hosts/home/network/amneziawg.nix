{ pkgs, identity, ... }:

let
  awgg = pkgs.writeShellApplication {
    name = "awgg";
    runtimeInputs = with pkgs; [ 
      coreutils 
      findutils 
      gum 
      iputils
      amneziawg-go
      amneziawg-tools 
      psmisc
      gawk
    ];
    text = ''
      r() { gum style --foreground 1 "$*"; }
      g() { gum style --foreground 2 "$*"; }
      y() { gum style --foreground 3 "$*"; }
      b() { gum style --foreground 4 "$*"; }
      m() { gum style --foreground 5 "$*"; }
      w() { gum style --foreground 7 "$*"; }

      check_ping() {
        local target="$1"
        local ping_out
        if ping_out=$(ping -c 1 -W 2 "$target" 2>&1); then
          local rtt
          rtt=$(printf "%s\n" "$ping_out" | awk -F'time=' '/time=/ {print $2}' | cut -d' ' -f1)
          gum join --horizontal "$(g "[+] ")" "ping $target: " "$(g "OK ($rtt ms)")"
          return 0
        else
          gum join --horizontal "$(r "[!] ")" "ping $target: " "$(r "FAILED")"
          return 1
        fi
      }

      if [ "$EUID" -ne 0 ]; then
        exec sudo "$0" "$@"
      fi

      awg-quick down /etc/amneziawg/active.conf >/dev/null 2>&1 || true
      killall amneziawg-go >/dev/null 2>&1 || true

      SOURCE_DIR="/home/${identity.username}/vpn/amneziawg"
      TARGET_DIR="/etc/amneziawg"
      TARGET_CONF="$TARGET_DIR/active.conf"

      if [ ! -d "$SOURCE_DIR" ]; then
        echo
        gum join --horizontal "$(r "[!] ")" "Error: Directory " "$(b "$SOURCE_DIR")" " does not exist."
        exit 1
      fi

      SELECTED=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.conf" -printf "%f\n" | gum choose --header "Select VPN Endpoint")

      if [ -z "$SELECTED" ]; then
        exit 0
      fi

      gum join --horizontal "$(m "[>] ")" "Switching to " "$(b "$SELECTED")" "..."

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

      success=0

      if check_ping "google.com"; then
        success=1
      fi

      if check_ping "1.1.1.1"; then
        success=1
      fi

      if check_ping "rutracker.org"; then
        success=1
      fi

      if [ "$success" -eq 1 ]; then
        gum join --horizontal "$(g "[+] ")" "SUCCESS - Tunnel LIVE"
      else
        gum join --horizontal "$(y "[~] ")" "WARNING - Tunnel UP, ping failed"
      fi
    '';
  };

  awgd = pkgs.writeShellApplication {
    name = "awgd";
    runtimeInputs = with pkgs; [ amneziawg-tools psmisc gum ];
    text = ''
      r() { gum style --foreground 1 "$*"; }
      g() { gum style --foreground 2 "$*"; }
      y() { gum style --foreground 3 "$*"; }
      b() { gum style --foreground 4 "$*"; }
      m() { gum style --foreground 5 "$*"; }
      w() { gum style --foreground 7 "$*"; }

      if [ "$EUID" -ne 0 ]; then
        exec sudo "$0" "$@"
      fi
      
      awg-quick down /etc/amneziawg/active.conf 2>/dev/null || true
      killall amneziawg-go 2>/dev/null || true
      
      echo
      gum join --horizontal "$(g "[+] ")" "VPN Stopped."
    '';
  };
in
{
  environment.systemPackages = [ awgg awgd ];
}
