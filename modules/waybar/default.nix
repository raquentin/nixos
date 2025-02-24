{
  pkgs,
  lib,
  ...
}:
with lib; {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "idle_inhibitor"
        ];
        "hyprland/workspaces" = {
          format = "{name}";
        };
        "tray" = {
          spacing = 12;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "noidle";
            deactivated = "yesidle";
          };
        };
      }
    ];
    style = concatStrings [
      ''
        * {
          font-family: JetBrains Mono;
          font-size: 12px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
          background: transparent;
        }
        #workspaces {
          color: #ffffff;
          background: #040404;
          margin: 4px 4px;
        }
        #workspaces button.active {
          font-weight: bold;
          background: #101010;
        }
      ''
    ];
  };
}
