final: prev:

rec {
  aws-okta-processor = import ./pkgs/aws-okta-processor.nix {
    inherit (self.pkgs) lib fetchFromGithub python39Packages;
    inherit (self.pkgs.python39Packages) requests beautifulsoup4 docopt boto3 contextlib2;
  };
}
