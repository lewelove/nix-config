{ pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    # lutris
    # luanti
    rimsort
  ];

  programs.gamemode.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
    cpufreq = {
      min = 3600000;
      max = 3600000;
    };
  };

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
