{ pkgs, buildPkgs }:
{
  build-lambda = pkgs.callPackage ./build-lambda { inherit (buildPkgs) poetry2nix zip python3; };
}
