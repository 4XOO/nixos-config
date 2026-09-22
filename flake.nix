


{
  description = "your mom";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    qylock.url = "github:Darkkal44/qylock";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    liquify-theme = {
      url = "github:NMWplays/Liquify";
      flake = false;
    };   
   };

outputs = { self, nixpkgs, home-manager, noctalia, spicetify-nix, qylock, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        ({ ... }: {
          home-manager.extraSpecialArgs = { inherit inputs; };
        })

        # Home-Manager Modules
        home-manager.nixosModules.home-manager

	# noctalia stuf
        noctalia.nixosModules.default
	inputs.noctalia-greeter.nixosModules.default

        spicetify-nix.nixosModules.default

        # Qylock Modules
        qylock.nixosModules.default
      ];
    };
  };
}
