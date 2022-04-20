final: prev:

rec {
  aws-okta-processor = (import ./pkgs/aws-okta-processor.nix) {
    inherit (prev.pkgs) lib fetchFromGitHub python39Packages;
    inherit (prev.pkgs.python39Packages)
      requests beautifulsoup4 docopt boto3 contextlib2;
  };
  aws-gate = (import ./pkgs/aws-gate.nix) {
    inherit (prev.pkgs) lib fetchFromGitHub python39 python39Packages;
  };
}
