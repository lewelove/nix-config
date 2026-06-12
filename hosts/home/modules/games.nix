{ pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    # lutris
    # luanti
    rimsort
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.xpadneo.enable = false;

}
