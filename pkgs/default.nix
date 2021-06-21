{ pkgs, buildPkgs }: {
  build-lambda = pkgs.callPackage ./build-lambda {
    inherit (buildPkgs) srcOnly poetry2nix zip python3;
  };
}
