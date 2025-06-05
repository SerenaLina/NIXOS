{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nvimdots.url = "github:ayamir/nvimdots";
    home-manager = {
      url = "github:nix-community/home-manager";
     # nixpkgs.follows = "nixpkgs";
  };
};

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
