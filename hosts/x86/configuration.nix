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

  services.xserver.enable = true; # x11

  services.displayManager.sddm.enable = true; # kde plasma
  services.desktopManager.plasma6.enable = true; # kde plasma

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

  users.users.race = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Race Williams";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  # automatic login
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "race";

  environment.systemPackages = with pkgs; [
    git
    wget
  ];

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
