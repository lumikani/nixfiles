{
  description = "Personal NixOS and home-manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.muffin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./hosts/muffin/configuration.nix ];
    };
  };
}

