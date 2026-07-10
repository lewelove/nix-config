{ pkgs, identity, ... }:

let
  vpn = pkgs.writeShellApplication {
    name = "vpn";
    runtimeInputs = with pkgs; [ 
      coreutils 
      findutils 
      gum 
      iputils
      amneziawg-go
      amneziawg-tools 
      psmisc
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

      killall amneziawg-go 2>/dev/null || true
      
      mkdir -p "$TARGET_DIR"
      ln -sf "$SOURCE_DIR/$SELECTED" "$TARGET_CONF"

      awg-quick up "$TARGET_CONF" 2>/dev/null || true

      if ping -c 1 -W 5 google.com > /dev/null 2>&1; then
        echo ""
        gum join --horizontal ":: " "$(gum style --foreground 2 --bold "SUCCESS")" " - Tunnel LIVE"
        echo ":: Config:  $SELECTED"
      else
        echo ""
        gum join --horizontal ":: " "$(gum style --foreground 3 --bold "WARNING")" " - Tunnel UP, ping failed"
      fi
    '';
  };
in
{
  environment.systemPackages = [ vpn ];
}
