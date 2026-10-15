{ pkgs, ... }:

{
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     ayugram-desktop = prev.telegram-desktop.override {
  #       pname = "ayugram-desktop";
  #       unwrapped = prev.ayugram-desktop.unwrapped.overrideAttrs (oldAttrs: {
  #
  #         src = final.fetchFromGitHub {
  #           owner = "AyuGram";
  #           repo = "AyuGramDesktop";
  #           tag = "v7.2.9";
  #           hash = "sha256-JlZWJ+fWdJqgDMpPFLfkfFp/O65eQaA8GQD6ZY/SI/k=";
  #           fetchSubmodules = true;
  #         };
  #
  #         buildInputs = oldAttrs.buildInputs ++ [
  #           final.pango
  #           final.tlottie
  #         ];
  #       });
  #     };
  #   })
  # ];

  environment.systemPackages = [
    pkgs.ayugram-desktop
  ];
}

