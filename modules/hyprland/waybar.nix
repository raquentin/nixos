{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };
}
