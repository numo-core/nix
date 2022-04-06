{
  description = "template for building automated pre-commit hooks and CI checkers";

  inputs.pre-commit-hooks = {
    url = "github:alex-numo/pre-commit-hooks.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:numtide/flake-utils";
  };
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs, pre-commit-hooks, flake-utils }@inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };
      devShell =
        nixpkgs.legacyPackages.${system}.mkShell
          {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
          };
    });
}
