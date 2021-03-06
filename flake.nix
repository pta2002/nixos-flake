# The idea here is to make a configuration sharable accross machines
{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = github:pta2002/nixvim;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = github:nix-community/neovim-nightly-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs: let
    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        inputs.neovim-nightly.overlay
        (import ./overlays/awesome.nix)
      ];
    };

    lib = pkgs.lib;

    makeConfig = hostname: laptop: extra: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        inputs.nixvim.nixosModules.nixvim
        (import ./common.nix (inputs // { inherit pkgs laptop lib; }))
        ({ ... }: {
          networking.hostName = hostname;
        })
        (import ./profiles)
        extra
      ];
    };
  in {
    nixosConfigurations.mercury = makeConfig "mercury" true {};
    nixosConfigurations.hydrogen = makeConfig "hydrogen" false ({ ... }: {
      profiles.graphical.enable = true;
    });
  };
}
