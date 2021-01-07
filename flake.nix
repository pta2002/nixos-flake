# The idea here is to make a configuration sharable accross machines
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, ... }: let
    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.mercury = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        (import ./common.nix { inherit pkgs home-manager; })
        ({ ... }: {
          networking.hostName = "mercury";
        })
      ];
    };
  };
}
