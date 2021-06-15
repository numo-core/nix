{
  description = "A collection of opinionated technology for numo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
  };
  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      buildSystem = "x86_64-linux";
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {

      packages = forAllSystems (system: import pkgs/default.nix {
        pkgs = import nixpkgs { inherit system; };
        buildPkgs = import nixpkgs { inherit buildSystem; };
      });

      templates = {
        ci = {
          path = ./templates/ci;
          description = "A template for pre-commit checks that can also be used for CI";
        };
      };

    };

}
