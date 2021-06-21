builtIns@{ stdenv, callPackage, srcOnly, poetry2nix, zip, python3 }:

{ python ? python3, projectDir }:
let
  poetryApplication = rec {
    pkg = poetry2nix.mkPoetryApplication { inherit projectDir python; };
    pname = pkg.pname;
    version = pkg.version;
  };
  poetryEnv =
    python.buildEnv.override { extraLibs = [ poetryApplication.pkg ]; };
in stdenv.mkDerivation {
  pname = "${poetryApplication.pname}-lambda-zip";
  inherit (poetryApplication) version;
  src = poetryEnv;

  dontbuild = true;
  dontConfigure = true;

  installPhase = ''
    (cd $src/${python.sitePackages}; ${zip}/bin/zip -r $out *)
  '';
}
