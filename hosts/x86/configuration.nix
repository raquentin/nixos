{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
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

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      race = import ../../home-manager/home.nix;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = ""; # disable global registry
      nix-path = config.nix.nixPath;
    };
    channel.enable = false; # disable channels

    # make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.sessionPackages = [pkgs.hyprland];

  # x11 keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true; # CUPS to print documents

  # pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # docker
  virtualisation.docker = {
    enable = true;
  };

  # shell must be at system level
  programs.zsh.enable = true;
  programs.zsh.shellInit = "
    [ -z \"$TMUX\"  ] && { tmux attach || exec tmux new-session && exit;}
  ";

  users.users.race = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Race Williams";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  # fonts
  fonts.packages = with pkgs; [
    fira-code
    hack-font
    jetbrains-mono
    iosevka
  ];

  services.mullvad-vpn = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget

    swww
    rofi-wayland
    hyprpicker
    polkit_gnome
    hyprland
    grim
    slurp
    wl-clipboard
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.dbus.enable = true;

  services.udev.extraRules = ''
    # Allow access to video devices
    SUBSYSTEM=="drm", KERNEL=="card*", TAG+="seat", TAG+="master-of-seat"
  '';

  hardware = {
    opengl.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
