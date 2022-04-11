{ lib, fetchFromGitHub, python39Packages, requests, beautifulsoup4, docopt, boto3, contextlib2 }:

python39Packages.buildPythonApplication {
  pname = "aws_okta_processor";
  version = "1.7.1";
  src = fetchFromGitHub {
    # TODO: change back to godaddy once
    # https://github.com/godaddy/aws-okta-processor/pull/50 is merged
    owner = "alex-numo";
    repo = "aws-okta-processor";
    rev = "e49cd49f9e2daba11e0f1cd0150e8e24ff3ff911";
    sha256 = "153nkdz9z13nr3i2as40qxww3w4c0qipzaky7pwyfkypmdcivc83";
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
