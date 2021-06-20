{ poetry2nix, zip, python3, callPackage, buildPython ? python3, projectDir }:

buildPython.buildEnv.override {
  extraLibs = [ callPackage ./build-lambda-env { } ];
  postBuild = ''
    (cd $out/${buildPython.sitePackages}; ${zip}/bin/zip $out/lambda.zip *)
    rm -rf $out/bin $out/lib $out/include $out/share
  '';
}
