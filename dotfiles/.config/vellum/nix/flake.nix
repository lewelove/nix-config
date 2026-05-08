{
  description = "Vellum Core Toolchain";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    lib = {
      copyFlac = ''find . -maxdepth 2 -name "*.flac" -exec cp {} $out/ \;'';

      mkAlbum = { 
        pname, 
        sourceDisk ? null,
        sourceTorrent ? null,
        sourceMagnet ? null,
        sha256 ? null,
        fetchCommand ? null,
        metadata ? null, 
        metadataString ? null, 
        cover ? null, 
        ops ? self.lib.copyFlac
      }:
        let
          unwrap = s: if builtins.isString s && builtins.substring 0 1 s == "/" 
                      then /. + s 
                      else s;

          rawSrc = if (builtins.getEnv "VELLUM_STAGING_SRC") != "" then
                      /. + (builtins.getEnv "VELLUM_STAGING_SRC")
                    else if sourceDisk != null then 
                      unwrap sourceDisk
                    else 
                      throw "No source found for ${pname}";

          realSrc = builtins.path { 
            name = "${pname}-source"; 
            path = rawSrc; 
            inherit sha256; 
          };

          realMetadata = if metadata != null 
                         then builtins.path { name = "${pname}-metadata"; path = unwrap metadata; } 
                         else null;

          realCover = if cover != null 
                      then builtins.path { name = "${pname}-cover"; path = unwrap cover; } 
                      else null;

          coverExt = if cover != null then 
                       let 
                         base = builtins.baseNameOf (unwrap cover);
                         match = builtins.match ".*\\.([^.]+)$" base;
                       in if match != null then builtins.elemAt match 0 else "img"
                     else "";
        in
        pkgs.stdenv.mkDerivation {
          name = pname;
          src = realSrc;

          metadataPath = realMetadata;
          metadataContent = metadataString;
          coverPath = realCover;
          ext = coverExt;

          buildInputs = [ pkgs.flac pkgs.shntool pkgs.ffmpeg ];
          
          passAsFile = if metadataString != null then [ "metadataContent" ] else [];

          passthru = {
            inherit pname sourceMagnet sourceTorrent sha256 fetchCommand;
            sourceDisk = if (builtins.getEnv "VELLUM_STAGING_SRC") != "" then (builtins.getEnv "VELLUM_STAGING_SRC") else sourceDisk;
            usingMetadataFile = metadata != null;
          };
          
          buildPhase = ''
            mkdir -p $out
            
            if [ -d "$src" ]; then
              cd "$src"
            fi

            ${ops}
            
            if [ -n "$metadataPath" ]; then
              cp "$metadataPath" "$out/metadata.toml"
            elif [ -n "''${metadataContentPath:-}" ] && [ -f "$metadataContentPath" ]; then
              cp "$metadataContentPath" "$out/metadata.toml"
            fi

            if [ -n "$coverPath" ]; then
              cp "$coverPath" "$out/cover.$ext"
            fi
          '';

          installPhase = "true";
        };
    };
  };
}
