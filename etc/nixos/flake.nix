{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
	url = "github:youwen5/zen-browser-flake";
	inputs.nixpkgs.follows = "nixpkgs";
	};

	spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };

  outputs = { self, nixpkgs, zen-browser, spicetify-nix, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # This is the vital missing piece providing 'inputs' to configuration.nix
      specialArgs = { 
	inherit inputs;
	};

      modules = [
        ./configuration.nix
      ];
    };
  };
}
