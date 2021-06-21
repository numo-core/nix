{
  description = "A collection of opinionated technology for numo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    utils.url = "github:numtide/flake-utils";
    poetry2nix-src.url = "github:nix-community/poetry2nix";
  };
  outputs = { self, nixpkgs, utils, poetry2nix-src }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      buildSystem = "x86_64-linux";
    in utils.lib.eachSystem systems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix-src.overlay ];
        };
        buildPkgs = import nixpkgs {
          system = buildSystem;
          overlays = [ poetry2nix-src.overlay ];
        };
        _pkgs = import ./pkgs { inherit pkgs buildPkgs; };
      in {
        packages = { build-lambda = _pkgs.build-lambda; };
        templates = {
          ci = {
            path = ./templates/ci;
            description =
              "A template for pre-commit checks that can also be used for CI";
          };
        };
      });
}
