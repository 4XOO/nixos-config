{
  description = "Meine NixOS Flake Konfiguration mit Noctalia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    qylock.url = "github:Darkkal44/qylock";

    # Home-Manager hinzufügen
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, spicetify-nix, qylock, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # Home-Manager Modul hinzufügen
        home-manager.nixosModules.home-manager
        noctalia.nixosModules.default
        spicetify-nix.nixosModules.default
        
        # Qylock Modul hier hinzufügen
        qylock.nixosModules.default
      ];
    };
  };
}
