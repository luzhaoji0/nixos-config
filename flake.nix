{
  description = "Headless NixOS work VM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }:
    let
      mkSystem = system: hardware: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          hardware
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [ nixvim.homeModules.nixvim ];
              users.yuki = import ./home/yuki.nix;
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        macbook = mkSystem "aarch64-linux" {
          imports = [ ./hardware-configuration-macbook.nix ];
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
        };
        homepc = mkSystem "x86_64-linux" {
          imports = [ ./hardware-configuration-homepc.nix ];
          boot.loader.grub = {
            enable = true;
            device = "/dev/vda";
            useOSProber = true;
            fsIdentifier = "provided";
          };
        };
      };
    };
}
