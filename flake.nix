{
  description = "Raquentin's NixOS flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # allows declarative download of firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-colorscheme = {
      url = "github:kdheepak/monochrome.nvim";
      flake = false;
    };

    # the Hyprland window manager
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays {inherit inputs;};

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      x86 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/x86/configuration.nix];
      };
      m1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/m1/configuration.nix];
      };
    };
  };
}
