{ pkgs, username, dot, ... }:

{
  environment.systemPackages = with pkgs; [ qutebrowser ];
}
