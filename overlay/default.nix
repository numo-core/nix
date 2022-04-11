final: prev:

rec {
  aws-okta-processor = (prev.callPackage ./pkgs/aws-okta-processor.nix) {
    inherit (prev.pkgs) lib fetchFromGithub python39Packages;
    inherit (prev.pkgs.python39Packages) requests beautifulsoup4 docopt boto3 contextlib2;
  };
}
