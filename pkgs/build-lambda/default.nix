builtIns@{ srcOnly, poetry2nix, zip, python3 }:

{ python ? python3, projectDir }:
let
  poetryPackage = poetry2nix.mkPoetryApplication { inherit projectDir python; };
  poetryEnv = python.buildEnv.override {
    extraLibs = [ poetryPackage ];
    postBuild = ''
      (cd $out/${python.sitePackages}; ${zip}/bin/zip $out/lambda.zip *)
      rm -rf $out/bin $out/lib $out/include $out/share
    '';
  };
in srcOnly {
  name = "lambda";
  src = poetryEnv;
}
