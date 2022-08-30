{ lib, fetchFromGitHub, python39Packages, requests, beautifulsoup4, docopt, boto3, contextlib2 }:

python39Packages.buildPythonApplication {
  pname = "aws_okta_processor";
  version = "1.7.1";
  src = fetchFromGitHub {
    # TODO: change back to godaddy once
    # https://github.com/godaddy/aws-okta-processor/pull/50 is merged
    owner = "alex-numo";
    repo = "aws-okta-processor";
    rev = "fd41e9ae3c1a6dcbe844fec9664ade17924b4bb9";
    sha256 = "0hr5raxjam2afx7mgzch95ji9xsdfp0qih4a8a29vh2la2h9ahgm";
  };
  prePatch = ''
    substituteInPlace setup.py \
    --replace "bs4" "beautifulsoup4"
  '';
  doCheck = false;
  propagatedBuildInputs = [
    requests
    beautifulsoup4
    docopt
    boto3
    contextlib2
  ];
  meta = with lib; {
    homepage = "https://github.com/godaddy/aws-okta-processor";
    description = "Resource for fetching AWS Role credentials from Okta";
    maintainers = with maintainers; [ flurie ];
    platforms = platforms.all;
  };
}
