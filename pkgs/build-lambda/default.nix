builtIns@{ poetry2nix, zip, python3, system }:

{ python ? python3
, projectDir ? ./.
}:
let
  inherit system;
  poetryPackage = poetry2nix.mkPoetryApplication {
    projectDir = projectDir;
    python = python;
    overrides = poetry2nix.overrides;
  };
in

python.buildEnv.override {
  extraLibs = [ poetryPackage ];
  postBuild = ''
    (cd $out/${python.sitePackages}; ${zip}/bin/zip $out/lambda.zip *)
    rm -rf $out/bin $out/lib $out/include $out/share
  '';
}
