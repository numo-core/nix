{ pkgs, buildPkgs, projectDir ? ./., buildPython }:
{
  build-lambda = pkgs.callPackage ./build-lambda { inherit (buildPkgs) poetry2nix zip python3; inherit projectDir buildPython; };
}
