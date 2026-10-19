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
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
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
    };
}
