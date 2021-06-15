{ pkgs
, buildPkgs
, projectDir ? ./.
, buildPython ? buildPkgs.python3
}:
{
  build-lambda = import ./build-lambda { inherit (buildPkgs) poetry2nix zip python3; inherit projectDir buildPython; };
}
