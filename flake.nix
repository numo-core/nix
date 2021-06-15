{
  description = "A collection of opinionated technology for numo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      buildSystem = "x86_64-linux";
    in
    utils.lib.eachSystem systems
      (system: rec
      {
        packages =
          import ./pkgs {
            pkgs = import nixpkgs { inherit system; };
            buildPkgs = import nixpkgs { inherit buildSystem; };
          };

        templates = {
          ci = {
            path = ./templates/ci;
            description = "A template for pre-commit checks that can also be used for CI";
          };
        };
      };

  ;
}
