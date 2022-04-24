{
  description = "Personal NixOS and home-manager configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations.muffin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./hosts/muffin/configuration.nix
        { nixpkgs.overlays = [ nur.overlay ]; }
        home-manager.nixosModules.home-manager
      ];
    };
  };
}

