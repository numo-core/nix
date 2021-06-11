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
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
  outputs = { self, nixpkgs, pre-commit-hooks, flake-utils }@inputs:
    # have to override this because aarch64-darwin isn't a standard system yet
    let systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
    in
    flake-utils.lib.eachSystem systems
      (system:
        {
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
