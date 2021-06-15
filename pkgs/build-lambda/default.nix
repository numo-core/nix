builtIns@{ poetry2nix, zip, python3 }:

{ buildPython ? python3
, projectDir ? ./.
}:
let
  poetryPackage = poetry2nix.mkPoetryApplication {
    projectDir = projectDir;
    python = buildPython;
    overrides = poetry2nix.overrides;
  };
in

buildPython.buildEnv.override {
  extraLibs = [ poetryPackage ];
  postBuild = ''
    (cd $out/${buildPython.sitePackages}; ${zip}/bin/zip $out/lambda.zip *)
    rm -rf $out/bin $out/lib $out/include $out/share
  '';
}
