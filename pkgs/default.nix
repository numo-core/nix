{ pkgs, buildPkgs }:
{
  build-lambda = pkgs.callPackage ./build-lambda { inherit buildPkgs; };
}
