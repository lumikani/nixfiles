{
  description = "Personal NixOS and home-manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.muffin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/muffin/configuration.nix ];
    };
  };
}

