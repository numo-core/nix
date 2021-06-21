{ pkgs, buildPkgs }: {
  build-lambda = pkgs.callPackage ./build-lambda {
    inherit (buildPkgs) stdenv callPackage srcOnly poetry2nix zip python3;
  };
}
