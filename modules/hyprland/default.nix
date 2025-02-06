{ pkgs, lib, inputs }:

{
  imports = [
    ./waybar.nix
  ];

  # deps without config
  programs = {
    swww.enable = true; # wallpaper
    dunst.enable = true; # notifs
    rofi-wayland.enable = true; # app launcher
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # settings = {};
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
}
