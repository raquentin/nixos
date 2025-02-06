{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../modules/fastfetch
    ../modules/firefox
    ../modules/neovim
    ../modules/wezterm
    ../modules/zsh
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  home.username = "race";
  home.homeDirectory = "/home/race";

  home.packages = with pkgs; [
    # main applications
    obs-studio
    gimp

    # cli tools
    ripgrep
    jq
    eza
    fzf
    typst

    # pl
    python312
  ];

  programs.git = {
    enable = true;
    userName = "Race Williams";
    userEmail = "race@raquent.in";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
