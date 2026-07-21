{ pkgs, identity, ... }:

let
  fuzzel-file-paste = pkgs.writers.writeFishBin "fuzzel-file-paste" ''
    set TOML_FILE "/home/${identity.username}/.config/fuzzel/file-paste.toml"

    if not test -f "$TOML_FILE"
        exit 1
    end

    set -x TOML_FILE "$TOML_FILE"
    set JSON_DATA (${pkgs.nushell}/bin/nu -c 'open $env.TOML_FILE | get files | to json')

    set KEYS (echo "$JSON_DATA" | ${pkgs.jq}/bin/jq -r 'keys_unsorted | .[]')

    set SELECTION (printf "%s\n" $KEYS | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="File Paste: ")

    if test -z "$SELECTION"
        exit 0
    end

    set RUN_CMD (echo "$JSON_DATA" | ${pkgs.jq}/bin/jq -r --arg sel "$SELECTION" '.[$sel].run')

    if test -n "$RUN_CMD" -a "$RUN_CMD" != "null"
        sh -c "$RUN_CMD"
        if test $status -ne 0
            exit 1
        end
    end

    set PATHS (echo "$JSON_DATA" | ${pkgs.jq}/bin/jq -r --arg sel "$SELECTION" '.[$sel].paste | .[]')

    for path in $PATHS
        if test -z "$path"
            continue
        end

        set expanded_path (string replace -r '^~' "/home/${identity.username}" "$path")

        if not string match -r '^/' "$expanded_path" >/dev/null
            set expanded_path (${pkgs.coreutils}/bin/realpath "$expanded_path")
        end

        if not string match -r '^file://' "$expanded_path" >/dev/null
            set expanded_path "file://$expanded_path"
        end

        echo -n "$expanded_path" | ${pkgs.wl-clipboard}/bin/wl-copy -t text/uri-list
        sleep 0.1
        ${pkgs.wtype}/bin/wtype -M ctrl -M shift v -m shift -m ctrl
        sleep 0.1
    end
'';
in
{
  environment.systemPackages = [ fuzzel-file-paste ];
}
