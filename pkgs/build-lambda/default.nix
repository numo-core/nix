builtIns@{ poetry2nix, zip, python3 }:

{ python ? python3
, projectDir ? ./.
}:
let
  poetryPackage = poetry2nix.mkPoetryApplication {
    projectDir = projectDir;
    python = python;
    overrides = poetry2nix.overrides;
  };
in
{
  build-lambda = python.buildEnv.override {
    extraLibs = [ poetryPackage ];
    postBuild = ''
      (cd $out/${python.sitePackages}; ${zip}/bin/zip $out/lambda.zip *)
      rm -rf $out/bin $out/lib $out/include $out/share
    '';
  };
}
