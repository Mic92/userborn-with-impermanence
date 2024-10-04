{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
  };

  outputs =
    {
      nixpkgs,
      impermanence,
      disko,
      ...
    }:
    {
      nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disko-config.nix
          impermanence.nixosModules.impermanence
          disko.nixosModules.disko
        ];
      };
    };
}
