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

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nixos-hardware, ... }:
  let
    work = "work";
    gaiety = "gaiety";
  in {
    nixosConfigurations = {
      fl-lumi-xps = nixpkgs.lib.nixosSystem {
        specialArgs = { hostUse = work; };
        system = "x86_64-linux";
        modules = [
          ./hosts/fl-lumi-xps/configuration.nix
          { nixpkgs.overlays = [ nur.overlay ]; }
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = { hostUse = work; }; }
        ];
      };

      muffin = nixpkgs.lib.nixosSystem {
        specialArgs = { hostUse = gaiety; };
        system = "x86_64-linux";
        modules = [
          ./hosts/muffin/configuration.nix
          { nixpkgs.overlays = [ nur.overlay ]; }
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = { hostUse = gaiety; }; }
        ];
      };

      pancake = nixpkgs.lib.nixosSystem {
        specialArgs = { hostUse = gaiety; };
        system = "x86_64-linux";
        modules = [
          ./hosts/pancake/configuration.nix
          { nixpkgs.overlays = [ nur.overlay ]; }
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = { hostUse = gaiety; }; }
          nixos-hardware.nixosModules.lenovo-thinkpad-t490
        ];
      };
    };
  };
}

