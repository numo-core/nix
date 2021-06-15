{ pkgs
, buildPkgs
, projectDir ? ./.
, buildPython ? buildPkgs.python3
}:
{
  build-lambda = pkgs.callPackage ./build-lambda { inherit (buildPkgs) poetry2nix zip python3; inherit projectDir buildPython; };
}
